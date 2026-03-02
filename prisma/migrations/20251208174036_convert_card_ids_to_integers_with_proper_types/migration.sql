/*
  Warnings:

  - The primary key for the `cards` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `card_id_int` on the `cards` table. All the data in the column will be lost.
  - The primary key for the `match_round_actions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `match_round_actions` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `matchRoundId` on the `match_round_actions` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `playerId` on the `match_round_actions` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The `targetCardId` column on the `match_round_actions` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to alter the column `playerPosition` on the `match_round_actions` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(20)`.
  - The primary key for the `player_inventories` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `player_inventories` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `playerId` on the `player_inventories` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `modifiedById` on the `player_inventories` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `player_match_deck_cards` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `player_match_deck_cards` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `matchPlayerDeckId` on the `player_match_deck_cards` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - Changed the type of `id` on the `cards` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `cardId` on the `player_cards` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `cardId` on the `player_inventories` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `cardId` on the `player_match_deck_cards` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "public"."match_round_actions" DROP CONSTRAINT "match_round_actions_matchRoundId_fkey";

-- DropForeignKey
ALTER TABLE "public"."match_round_actions" DROP CONSTRAINT "match_round_actions_playerId_fkey";

-- DropForeignKey
ALTER TABLE "public"."match_round_actions" DROP CONSTRAINT "match_round_actions_targetCardId_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_cards" DROP CONSTRAINT "player_cards_cardId_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_inventories" DROP CONSTRAINT "player_inventories_cardId_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_inventories" DROP CONSTRAINT "player_inventories_modifiedById_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_inventories" DROP CONSTRAINT "player_inventories_playerId_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_match_deck_cards" DROP CONSTRAINT "player_match_deck_cards_cardId_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_match_deck_cards" DROP CONSTRAINT "player_match_deck_cards_matchPlayerDeckId_fkey";

-- DropIndex
DROP INDEX "public"."cards_card_id_int_key";

-- AlterTable
ALTER TABLE "public"."card_characters" ALTER COLUMN "id" DROP DEFAULT;

-- AlterTable
ALTER TABLE "public"."card_edition_types" ALTER COLUMN "id" DROP DEFAULT;

-- AlterTable
ALTER TABLE "public"."cards" DROP CONSTRAINT "cards_pkey",
DROP COLUMN "card_id_int",
DROP COLUMN "id",
ADD COLUMN     "id" INTEGER NOT NULL,
ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(6),
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMPTZ(6),
ADD CONSTRAINT "cards_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."match_round_actions" DROP CONSTRAINT "match_round_actions_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "matchRoundId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "playerId" SET DATA TYPE VARCHAR(36),
DROP COLUMN "targetCardId",
ADD COLUMN     "targetCardId" INTEGER,
ALTER COLUMN "actionTimestamp" SET DATA TYPE TIMESTAMPTZ(6),
ALTER COLUMN "playerPosition" SET DATA TYPE VARCHAR(20),
ADD CONSTRAINT "match_round_actions_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."player_cards" DROP COLUMN "cardId",
ADD COLUMN     "cardId" INTEGER NOT NULL,
ALTER COLUMN "acquiredAt" SET DATA TYPE TIMESTAMPTZ(6),
ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(6),
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMPTZ(6);

-- AlterTable
ALTER TABLE "public"."player_inventories" DROP CONSTRAINT "player_inventories_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "playerId" SET DATA TYPE VARCHAR(36),
DROP COLUMN "cardId",
ADD COLUMN     "cardId" INTEGER NOT NULL,
ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(6),
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMPTZ(6),
ALTER COLUMN "modifiedById" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "player_inventories_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."player_match_deck_cards" DROP CONSTRAINT "player_match_deck_cards_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "matchPlayerDeckId" SET DATA TYPE VARCHAR(36),
DROP COLUMN "cardId",
ADD COLUMN     "cardId" INTEGER NOT NULL,
ADD CONSTRAINT "player_match_deck_cards_pkey" PRIMARY KEY ("id");

-- CreateIndex
CREATE UNIQUE INDEX "player_inventories_playerId_cardId_key" ON "public"."player_inventories"("playerId", "cardId");

-- AddForeignKey
ALTER TABLE "public"."player_inventories" ADD CONSTRAINT "player_inventories_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_inventories" ADD CONSTRAINT "player_inventories_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_inventories" ADD CONSTRAINT "player_inventories_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_match_deck_cards" ADD CONSTRAINT "player_match_deck_cards_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_match_deck_cards" ADD CONSTRAINT "player_match_deck_cards_matchPlayerDeckId_fkey" FOREIGN KEY ("matchPlayerDeckId") REFERENCES "public"."match_player_decks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_matchRoundId_fkey" FOREIGN KEY ("matchRoundId") REFERENCES "public"."match_rounds"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_targetCardId_fkey" FOREIGN KEY ("targetCardId") REFERENCES "public"."cards"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_cards" ADD CONSTRAINT "player_cards_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
