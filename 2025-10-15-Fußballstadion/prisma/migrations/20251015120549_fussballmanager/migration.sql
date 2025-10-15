-- CreateTable
CREATE TABLE "Player" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "mannschaftId" INTEGER NOT NULL,
    CONSTRAINT "Player_mannschaftId_fkey" FOREIGN KEY ("mannschaftId") REFERENCES "Mannschaft" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Mannschaft" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Stadion" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "stadt" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Match" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "datum" DATETIME NOT NULL,
    "ergebnis" TEXT NOT NULL,
    "stadionId" INTEGER NOT NULL,
    "mannschaftAId" INTEGER NOT NULL,
    "mannschaftBId" INTEGER NOT NULL,
    CONSTRAINT "Match_stadionId_fkey" FOREIGN KEY ("stadionId") REFERENCES "Stadion" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Match_mannschaftAId_fkey" FOREIGN KEY ("mannschaftAId") REFERENCES "Mannschaft" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Match_mannschaftBId_fkey" FOREIGN KEY ("mannschaftBId") REFERENCES "Mannschaft" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
