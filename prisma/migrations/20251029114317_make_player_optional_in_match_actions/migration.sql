-- DropForeignKey
ALTER TABLE "public"."match_round_actions" DROP CONSTRAINT "match_round_actions_playerId_fkey";

-- DropForeignKey
ALTER TABLE "public"."match_round_energies" DROP CONSTRAINT "match_round_energies_playerId_fkey";

-- AlterTable
ALTER TABLE "public"."match_round_actions" ADD COLUMN     "playerPosition" TEXT,
ALTER COLUMN "playerId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "public"."match_round_energies" ADD COLUMN     "playerPosition" TEXT,
ALTER COLUMN "playerId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "public"."match_round_energies" ADD CONSTRAINT "match_round_energies_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;
