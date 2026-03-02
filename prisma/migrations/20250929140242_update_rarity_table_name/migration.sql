/*
  Warnings:

  - You are about to drop the `Rarity` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."cards" DROP CONSTRAINT "cards_cardRarityId_fkey";

-- DropForeignKey
ALTER TABLE "public"."lootbox_rarities" DROP CONSTRAINT "lootbox_rarities_rarityId_fkey";

-- AlterTable
ALTER TABLE "public"."users" ALTER COLUMN "userRoleId" SET DEFAULT 1;

-- DropTable
DROP TABLE "public"."Rarity";

-- CreateTable
CREATE TABLE "public"."rarities" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "rarities_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "rarities_name_key" ON "public"."rarities"("name");

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_cardRarityId_fkey" FOREIGN KEY ("cardRarityId") REFERENCES "public"."rarities"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lootbox_rarities" ADD CONSTRAINT "lootbox_rarities_rarityId_fkey" FOREIGN KEY ("rarityId") REFERENCES "public"."rarities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
