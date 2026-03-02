/*
  Warnings:

  - The `topCards` column on the `leaderboard` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `topCards` column on the `players` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "public"."leaderboard" DROP COLUMN "topCards",
ADD COLUMN     "topCards" INTEGER[];

-- AlterTable
ALTER TABLE "public"."players" DROP COLUMN "topCards",
ADD COLUMN     "topCards" INTEGER[] DEFAULT ARRAY[]::INTEGER[];
