import * as passenger from "./repository/passenger.ts";
import * as plane from "./repository/plane.ts";
import * as airport from "./repository/airport.ts";
import * as flight from "./repository/flight.ts";
import { disconnect } from "./repository/db.ts";

async function main() {
    console.log('Passengers:', await passenger.count());
    console.log('Planes:', await plane.count());
    console.log('Airports:', await airport.count());
    console.log('Flights:', await flight.count());
    await disconnect();
}

main();
