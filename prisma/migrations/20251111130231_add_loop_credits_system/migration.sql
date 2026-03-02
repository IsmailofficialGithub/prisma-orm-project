-- AlterTable
ALTER TABLE "public"."match_summaries" ADD COLUMN     "player1LcGain" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "player2LcGain" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "public"."players" ADD COLUMN     "loopCredits" INTEGER NOT NULL DEFAULT 0;
