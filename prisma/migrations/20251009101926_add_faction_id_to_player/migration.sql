-- AlterTable
ALTER TABLE "public"."players" ALTER COLUMN "level" SET DEFAULT 0;

-- AddForeignKey
ALTER TABLE "public"."players" ADD CONSTRAINT "players_factionId_fkey" FOREIGN KEY ("factionId") REFERENCES "public"."factions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
