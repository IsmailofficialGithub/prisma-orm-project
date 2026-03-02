-- CreateEnum
CREATE TYPE "public"."AcquiredFrom" AS ENUM ('LOOTBOX', 'REWARD', 'STARTER');

-- AlterTable
ALTER TABLE "public"."card_types" ADD COLUMN     "modifiedById" TEXT;

-- AlterTable
ALTER TABLE "public"."cards" ADD COLUMN     "cardRarityId" INTEGER,
ADD COLUMN     "modifiedById" TEXT;

-- AlterTable
ALTER TABLE "public"."currencies" ADD COLUMN     "modifiedById" TEXT;

-- AlterTable
ALTER TABLE "public"."currency_types" ADD COLUMN     "modifiedById" TEXT;

-- AlterTable
ALTER TABLE "public"."deck_cards" ADD COLUMN     "modifiedById" TEXT,
ADD COLUMN     "ownerId" TEXT,
ADD COLUMN     "userId" TEXT;

-- AlterTable
ALTER TABLE "public"."decks" ADD COLUMN     "modifiedById" TEXT;

-- AlterTable
ALTER TABLE "public"."factions" ADD COLUMN     "modifiedById" TEXT;

-- AlterTable
ALTER TABLE "public"."stages" ADD COLUMN     "modifiedById" TEXT;

-- AlterTable
ALTER TABLE "public"."user_inventories" ADD COLUMN     "modifiedById" TEXT;

-- AlterTable
ALTER TABLE "public"."users" ADD COLUMN     "currencyId" TEXT;

-- CreateTable
CREATE TABLE "public"."user_cards" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "acquiredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acquiredFrom" "public"."AcquiredFrom" NOT NULL,
    "isMinted" BOOLEAN NOT NULL DEFAULT false,
    "modifiedById" TEXT,

    CONSTRAINT "user_cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."_UserToUserInventory" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_UserToUserInventory_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_cards_userId_cardId_key" ON "public"."user_cards"("userId", "cardId");

-- CreateIndex
CREATE INDEX "_UserToUserInventory_B_index" ON "public"."_UserToUserInventory"("B");

-- AddForeignKey
ALTER TABLE "public"."factions" ADD CONSTRAINT "factions_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."card_types" ADD CONSTRAINT "card_types_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."stages" ADD CONSTRAINT "stages_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_cardRarityId_fkey" FOREIGN KEY ("cardRarityId") REFERENCES "public"."Rarity"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."currency_types" ADD CONSTRAINT "currency_types_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."currencies" ADD CONSTRAINT "currencies_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."decks" ADD CONSTRAINT "decks_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_inventories" ADD CONSTRAINT "user_inventories_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."users" ADD CONSTRAINT "users_currencyId_fkey" FOREIGN KEY ("currencyId") REFERENCES "public"."currencies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_cards" ADD CONSTRAINT "user_cards_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_cards" ADD CONSTRAINT "user_cards_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_cards" ADD CONSTRAINT "user_cards_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_UserToUserInventory" ADD CONSTRAINT "_UserToUserInventory_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_UserToUserInventory" ADD CONSTRAINT "_UserToUserInventory_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."user_inventories"("id") ON DELETE CASCADE ON UPDATE CASCADE;
