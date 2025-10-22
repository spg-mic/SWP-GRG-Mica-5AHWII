/*
Lift
a lift moves between a number of floors.
a lift has a panel of buttons passengers can press to request floors.
people can call the lift from other floors. A call has both a floor and a desired direction.
a lift has doors which may be open or closed.
a lift fulfills a request when it moves to the requested floor and opens the doors.
a lift fulfills a call when it moves to the correct floor, is about to go in the called direction, and opens the doors.
a lift can only move between floors if the doors are closed.
Additional features
When you have a single lift working, you may want to tackle these further features:

there can be more than one lift.
only one lift needs to respond to each call.
on each floor there is a monitor above each lift door. While the lift is moving it shows which floor it is on.
when the lift stops at a floor to answer a call, the monitor shows which direction it will go in.
when fulfilling a call, the relevant lift makes a ‘DING’ as it opens the doors.
*/
/**
 * Einfaches Lift-System mit Kommentaren.
 */

type Direction = "up" | "down" | "none";

// Hilfsfunktion für Delay (Warten)
function wait(ms: number) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

class Lift {
    currentFloor: number;
    totalFloors: number;
    doorsOpen: boolean;
    requests: Set<number>;
    callFloor: number | null;
    callDirection: Direction;
    busy: boolean; // Zeigt an, ob der Lift gerade beschäftigt ist

    constructor(totalFloors: number) {
        this.currentFloor = 0;
        this.totalFloors = totalFloors;
        this.doorsOpen = false;
        this.requests = new Set();
        this.callFloor = null;
        this.callDirection = "none";
        this.busy = false;
    }

    requestFloor(floor: number) {
        if (floor >= 0 && floor < this.totalFloors) {
            this.requests.add(floor);
            console.log(`Etage ${floor} angefordert.`);
        }
    }

    callLift(floor: number, direction: Direction) {
        if (floor >= 0 && floor < this.totalFloors) {
            this.callFloor = floor;
            this.callDirection = direction;
            console.log(`Lift gerufen auf Etage ${floor} Richtung ${direction}.`);
        }
    }

    // Schrittweise Steuerung mit Zeitverzögerung
    async step() {
        if (this.busy) return; // Verhindert Überschneidungen
        this.busy = true;

        // Türen schließen, bevor der Lift fährt
        if (this.doorsOpen) {
            await this.closeDoors();
            this.busy = false;
            return;
        }

        // Priorität: Call abarbeiten
        if (this.callFloor !== null && this.currentFloor !== this.callFloor) {
            await this.moveTo(this.callFloor);
        } else if (this.requests.size > 0) {
            const next = [...this.requests][0];
            await this.moveTo(next);
        } else {
            console.log("Lift wartet.");
        }
        this.busy = false;
    }

    // Lift bewegt sich zu einer Etage (mit Zeitverzögerung)
    async moveTo(floor: number) {
        if (floor > this.currentFloor) {
            this.currentFloor++;
            this.showMonitor("up");
            await wait(3000); // 3 Sekunden pro Stockwerk
        } else if (floor < this.currentFloor) {
            this.currentFloor--;
            this.showMonitor("down");
            await wait(3000); // 3 Sekunden pro Stockwerk
        } else {
            // Ziel erreicht
            await this.openDoors();
            if (this.callFloor === this.currentFloor) {
                console.log("DING! Call erfüllt.");
                this.callFloor = null;
                this.callDirection = "none";
            }
            if (this.requests.has(this.currentFloor)) {
                console.log("Request erfüllt.");
                this.requests.delete(this.currentFloor);
            }
        }
    }

    // Türen öffnen (dauert 1 Sekunde)
    async openDoors() {
        this.doorsOpen = true;
        console.log(`Türen auf Etage ${this.currentFloor} geöffnet.`);
        await wait(1000);
    }

    // Türen schließen (dauert 1 Sekunde)
    async closeDoors() {
        this.doorsOpen = false;
        console.log("Türen geschlossen.");
        await wait(1000);
    }

    showMonitor(direction: Direction) {
        console.log(`Lift auf Etage ${this.currentFloor}, Richtung: ${direction}`);
    }
}

// Beispiel-Nutzung:
const lift = new Lift(100);

// Beispiel: Nur gültige Etagen anfordern
lift.callLift(20, "up");
lift.requestFloor(0);

// Simuliere Schritte asynchron
(async () => {
    while (lift.callFloor !== null || lift.requests.size > 0 || lift.doorsOpen) {
        await lift.step();
    }
    console.log("Alle Fahrten erledigt!");
})();