/*
  Warnings:

  - You are about to drop the column `userId` on the `currencies` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `deck_cards` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `decks` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `orders` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `orders` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `ranks` table. All the data in the column will be lost.
  - You are about to drop the column `currencyId` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `_UserToUserInventory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_cards` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_inventories` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[playerId,currencyTypeId]` on the table `currencies` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `playerId` to the `currencies` table without a default value. This is not possible if the table is not empty.
  - Added the required column `playerId` to the `decks` table without a default value. This is not possible if the table is not empty.
  - Added the required column `orderStatusId` to the `orders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `playerId` to the `orders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `playerId` to the `ranks` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userRoleId` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."_UserToUserInventory" DROP CONSTRAINT "_UserToUserInventory_A_fkey";

-- DropForeignKey
ALTER TABLE "public"."_UserToUserInventory" DROP CONSTRAINT "_UserToUserInventory_B_fkey";

-- DropForeignKey
ALTER TABLE "public"."card_types" DROP CONSTRAINT "card_types_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."cards" DROP CONSTRAINT "cards_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."currencies" DROP CONSTRAINT "currencies_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."currencies" DROP CONSTRAINT "currencies_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."currency_types" DROP CONSTRAINT "currency_types_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."deck_cards" DROP CONSTRAINT "deck_cards_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."deck_cards" DROP CONSTRAINT "deck_cards_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "public"."deck_cards" DROP CONSTRAINT "deck_cards_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."decks" DROP CONSTRAINT "decks_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."decks" DROP CONSTRAINT "decks_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."factions" DROP CONSTRAINT "factions_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."orders" DROP CONSTRAINT "orders_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."ranks" DROP CONSTRAINT "ranks_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."stages" DROP CONSTRAINT "stages_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."user_cards" DROP CONSTRAINT "user_cards_cardId_fkey";

-- DropForeignKey
ALTER TABLE "public"."user_cards" DROP CONSTRAINT "user_cards_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."user_cards" DROP CONSTRAINT "user_cards_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."user_inventories" DROP CONSTRAINT "user_inventories_cardId_fkey";

-- DropForeignKey
ALTER TABLE "public"."user_inventories" DROP CONSTRAINT "user_inventories_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."user_inventories" DROP CONSTRAINT "user_inventories_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."users" DROP CONSTRAINT "users_currencyId_fkey";

-- DropIndex
DROP INDEX "public"."currencies_userId_currencyTypeId_key";

-- AlterTable
ALTER TABLE "public"."currencies" DROP COLUMN "userId",
ADD COLUMN     "playerId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."deck_cards" DROP COLUMN "userId",
ADD COLUMN     "playerId" TEXT;

-- AlterTable
ALTER TABLE "public"."decks" DROP COLUMN "userId",
ADD COLUMN     "playerId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."orders" DROP COLUMN "status",
DROP COLUMN "userId",
ADD COLUMN     "orderStatusId" INTEGER NOT NULL,
ADD COLUMN     "playerId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."ranks" DROP COLUMN "userId",
ADD COLUMN     "playerId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."users" DROP COLUMN "currencyId",
ADD COLUMN     "userRoleId" INTEGER NOT NULL;

-- DropTable
DROP TABLE "public"."_UserToUserInventory";

-- DropTable
DROP TABLE "public"."user_cards";

-- DropTable
DROP TABLE "public"."user_inventories";

-- DropEnum
DROP TYPE "public"."AcquiredFrom";

-- DropEnum
DROP TYPE "public"."OrderStatus";

-- CreateTable
CREATE TABLE "public"."player_inventories" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "modifiedById" TEXT,

    CONSTRAINT "player_inventories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."order_statuses" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "order_statuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."players" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "players_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."player_cards" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "acquiredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "playerCardAcquiredFromId" INTEGER NOT NULL,
    "isMinted" BOOLEAN NOT NULL DEFAULT false,
    "modifiedById" TEXT,

    CONSTRAINT "player_cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."player_card_acquired_from" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "player_card_acquired_from_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_roles" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "user_roles_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "player_inventories_playerId_cardId_key" ON "public"."player_inventories"("playerId", "cardId");

-- CreateIndex
CREATE UNIQUE INDEX "order_statuses_name_key" ON "public"."order_statuses"("name");

-- CreateIndex
CREATE UNIQUE INDEX "players_username_key" ON "public"."players"("username");

-- CreateIndex
CREATE UNIQUE INDEX "players_email_key" ON "public"."players"("email");

-- CreateIndex
CREATE UNIQUE INDEX "player_cards_playerId_cardId_key" ON "public"."player_cards"("playerId", "cardId");

-- CreateIndex
CREATE UNIQUE INDEX "player_card_acquired_from_name_key" ON "public"."player_card_acquired_from"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_roles_name_key" ON "public"."user_roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "currencies_playerId_currencyTypeId_key" ON "public"."currencies"("playerId", "currencyTypeId");

-- AddForeignKey
ALTER TABLE "public"."factions" ADD CONSTRAINT "factions_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."card_types" ADD CONSTRAINT "card_types_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."stages" ADD CONSTRAINT "stages_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."currency_types" ADD CONSTRAINT "currency_types_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."currencies" ADD CONSTRAINT "currencies_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."currencies" ADD CONSTRAINT "currencies_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."decks" ADD CONSTRAINT "decks_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."decks" ADD CONSTRAINT "decks_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_inventories" ADD CONSTRAINT "player_inventories_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_inventories" ADD CONSTRAINT "player_inventories_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_inventories" ADD CONSTRAINT "player_inventories_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_orderStatusId_fkey" FOREIGN KEY ("orderStatusId") REFERENCES "public"."order_statuses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_cards" ADD CONSTRAINT "player_cards_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_cards" ADD CONSTRAINT "player_cards_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_cards" ADD CONSTRAINT "player_cards_playerCardAcquiredFromId_fkey" FOREIGN KEY ("playerCardAcquiredFromId") REFERENCES "public"."player_card_acquired_from"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_cards" ADD CONSTRAINT "player_cards_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ranks" ADD CONSTRAINT "ranks_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."users" ADD CONSTRAINT "users_userRoleId_fkey" FOREIGN KEY ("userRoleId") REFERENCES "public"."user_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
