/*
  Warnings:

  - You are about to drop the column `cardRarityId` on the `cards` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."cards" DROP CONSTRAINT "cards_cardRarityId_fkey";

-- AlterTable
ALTER TABLE "public"."cards" DROP COLUMN "cardRarityId",
ADD COLUMN     "rarityId" INTEGER;

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_rarityId_fkey" FOREIGN KEY ("rarityId") REFERENCES "public"."rarities"("id") ON DELETE SET NULL ON UPDATE CASCADE;
