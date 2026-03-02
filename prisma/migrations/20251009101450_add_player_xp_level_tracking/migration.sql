-- AlterTable
ALTER TABLE "public"."match_summaries" ADD COLUMN     "player1LevelUp" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "player1XpGain" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "player2LevelUp" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "player2XpGain" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "public"."players" ADD COLUMN     "level" INTEGER NOT NULL DEFAULT 1,
ADD COLUMN     "totalXp" INTEGER NOT NULL DEFAULT 0;
