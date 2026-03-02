/*
  Warnings:

  - You are about to drop the column `player1LevelUp` on the `match_summaries` table. All the data in the column will be lost.
  - You are about to drop the column `player2LevelUp` on the `match_summaries` table. All the data in the column will be lost.
  - You are about to drop the column `level` on the `players` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "public"."match_summaries" DROP COLUMN "player1LevelUp",
DROP COLUMN "player2LevelUp";

-- AlterTable
ALTER TABLE "public"."players" DROP COLUMN "level";
