/*
  Warnings:

  - You are about to drop the `Airport` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Flight` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Passenger` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Plane` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_FlightToPassenger` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Airport";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Flight";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Passenger";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Plane";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_FlightToPassenger";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Address" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "street" TEXT NOT NULL,
    "postalCode" TEXT NOT NULL,
    "city" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Kunde" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "vorname" TEXT NOT NULL,
    "nachname" TEXT NOT NULL,
    "addressId" INTEGER NOT NULL,
    CONSTRAINT "Kunde_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Auftrag" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "kundennummer" INTEGER NOT NULL,
    "datum" DATETIME NOT NULL,
    CONSTRAINT "Auftrag_kundennummer_fkey" FOREIGN KEY ("kundennummer") REFERENCES "Kunde" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Buch" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "autor" TEXT NOT NULL,
    "titel" TEXT NOT NULL,
    "preis" REAL NOT NULL,
    "auslaufend" BOOLEAN NOT NULL DEFAULT false,
    "bestand" INTEGER NOT NULL DEFAULT 0,
    "verlagShortCode" TEXT NOT NULL,
    CONSTRAINT "Buch_verlagShortCode_fkey" FOREIGN KEY ("verlagShortCode") REFERENCES "Verlag" ("shortCode") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Verlag" (
    "shortCode" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "addressId" INTEGER NOT NULL,
    CONSTRAINT "Verlag_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "OrderItem" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "auftragId" INTEGER NOT NULL,
    "buchId" INTEGER NOT NULL,
    "menge" INTEGER NOT NULL DEFAULT 1,
    "preisZumBestellzeitpunkt" REAL NOT NULL,
    CONSTRAINT "OrderItem_auftragId_fkey" FOREIGN KEY ("auftragId") REFERENCES "Auftrag" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "OrderItem_buchId_fkey" FOREIGN KEY ("buchId") REFERENCES "Buch" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "OrderItem_auftragId_buchId_key" ON "OrderItem"("auftragId", "buchId");
