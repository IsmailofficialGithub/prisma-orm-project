-- AlterTable
ALTER TABLE "public"."players" ADD COLUMN     "heroId" INTEGER DEFAULT 1;

-- CreateTable
CREATE TABLE "public"."heroes" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "factionId" INTEGER NOT NULL,
    "hp" INTEGER NOT NULL,

    CONSTRAINT "heroes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "heroes_name_key" ON "public"."heroes"("name");

-- AddForeignKey
ALTER TABLE "public"."heroes" ADD CONSTRAINT "heroes_factionId_fkey" FOREIGN KEY ("factionId") REFERENCES "public"."factions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."players" ADD CONSTRAINT "players_heroId_fkey" FOREIGN KEY ("heroId") REFERENCES "public"."heroes"("id") ON DELETE SET NULL ON UPDATE CASCADE;
