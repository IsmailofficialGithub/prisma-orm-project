/*
  Warnings:

  - You are about to alter the column `playerId` on the `player_cards` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `cardId` on the `player_cards` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.

*/
-- DropForeignKey
ALTER TABLE "public"."player_cards" DROP CONSTRAINT "player_cards_cardId_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_cards" DROP CONSTRAINT "player_cards_playerId_fkey";

-- DropIndex
DROP INDEX "public"."player_cards_playerId_cardId_key";

-- AlterTable
ALTER TABLE "public"."player_cards" ALTER COLUMN "playerId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "cardId" SET DATA TYPE VARCHAR(36);

-- AddForeignKey
ALTER TABLE "public"."player_cards" ADD CONSTRAINT "player_cards_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_cards" ADD CONSTRAINT "player_cards_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
