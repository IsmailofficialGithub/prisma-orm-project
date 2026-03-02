/*
  Warnings:

  - You are about to drop the column `cardId` on the `deck_cards` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[deckId,player_card_unique_id]` on the table `deck_cards` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id]` on the table `player_cards` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `player_card_unique_id` to the `deck_cards` table without a default value. This is not possible if the table is not empty.

*/

-- Step 1: Add the new column as nullable first
ALTER TABLE "public"."deck_cards" ADD COLUMN "player_card_unique_id" TEXT;

-- Step 2: Populate the new column with corresponding PlayerCard IDs
-- This requires finding the first matching PlayerCard for each DeckCard
UPDATE "public"."deck_cards" 
SET "player_card_unique_id" = (
  SELECT pc.id 
  FROM "public"."player_cards" pc
  JOIN "public"."decks" d ON d.id = "deck_cards"."deckId"
  WHERE pc."playerId" = d."playerId" 
    AND pc."cardId" = "deck_cards"."cardId"
    AND pc."isMinted" = true
  LIMIT 1
);

-- Step 3: Remove rows where we couldn't find a matching PlayerCard
DELETE FROM "public"."deck_cards" WHERE "player_card_unique_id" IS NULL;

-- Step 4: Make the column required
ALTER TABLE "public"."deck_cards" ALTER COLUMN "player_card_unique_id" SET NOT NULL;

-- Step 5: Drop the old foreign key and index
ALTER TABLE "public"."deck_cards" DROP CONSTRAINT "deck_cards_cardId_fkey";
DROP INDEX "public"."deck_cards_deckId_cardId_key";

-- Step 6: Drop the old cardId column
ALTER TABLE "public"."deck_cards" DROP COLUMN "cardId";

-- Step 7: Create new indexes and constraints
CREATE UNIQUE INDEX "deck_cards_deckId_player_card_unique_id_key" ON "public"."deck_cards"("deckId", "player_card_unique_id");
CREATE UNIQUE INDEX "player_cards_id_key" ON "public"."player_cards"("id");

-- Step 8: Add the new foreign key
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_player_card_unique_id_fkey" FOREIGN KEY ("player_card_unique_id") REFERENCES "public"."player_cards"("id") ON DELETE CASCADE ON UPDATE CASCADE;
