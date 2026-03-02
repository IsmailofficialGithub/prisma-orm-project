/*
  Comprehensive Card Schema Refactor Migration
  - Rename player_card_acquired_from table to card_acquisition_types (preserves data)
  - Rename playerCardAcquiredFromId column to card_acquisition_type_id (preserves data)
  - Add new fields to player_cards: total_damage_done, total_damage_taken, total_wins
  - Add lore field to cards table
  - Update description field length in cards table
  - Update modifiedById field type in cards table  
  - Remove unused fields: active, passive, ultimate, tags (all empty in database)
*/

-- First check if the old table exists and rename it (data-safe approach)
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'player_card_acquired_from') THEN
        -- Drop foreign key constraint first
        ALTER TABLE "public"."player_cards" DROP CONSTRAINT IF EXISTS "player_cards_playerCardAcquiredFromId_fkey";
        
        -- Rename table to preserve data
        ALTER TABLE "public"."player_card_acquired_from" RENAME TO "card_acquisition_types";
        
        -- Rename constraints and indexes
        ALTER TABLE "public"."card_acquisition_types" RENAME CONSTRAINT "player_card_acquired_from_pkey" TO "card_acquisition_types_pkey";
        ALTER INDEX IF EXISTS "player_card_acquired_from_name_key" RENAME TO "card_acquisition_types_name_key";
        
        -- Rename column in player_cards to preserve data
        ALTER TABLE "public"."player_cards" RENAME COLUMN "playerCardAcquiredFromId" TO "card_acquisition_type_id";
    ELSE
        -- Create table if it doesn't exist
        CREATE TABLE IF NOT EXISTS "public"."card_acquisition_types" (
            "id" SERIAL NOT NULL,
            "name" TEXT NOT NULL,
            CONSTRAINT "card_acquisition_types_pkey" PRIMARY KEY ("id")
        );
        CREATE UNIQUE INDEX IF NOT EXISTS "card_acquisition_types_name_key" ON "public"."card_acquisition_types"("name");
        
        -- Add column if it doesn't exist
        ALTER TABLE "public"."player_cards" ADD COLUMN IF NOT EXISTS "card_acquisition_type_id" INTEGER;
    END IF;
END
$$;

-- Update cards table
ALTER TABLE "public"."cards" DROP CONSTRAINT IF EXISTS "cards_modifiedById_fkey";

-- Remove unused columns if they exist
ALTER TABLE "public"."cards" DROP COLUMN IF EXISTS "active";
ALTER TABLE "public"."cards" DROP COLUMN IF EXISTS "passive"; 
ALTER TABLE "public"."cards" DROP COLUMN IF EXISTS "tags";
ALTER TABLE "public"."cards" DROP COLUMN IF EXISTS "ultimate";

-- Add new columns and update existing ones
ALTER TABLE "public"."cards" ADD COLUMN IF NOT EXISTS "lore" VARCHAR(10000);
ALTER TABLE "public"."cards" ALTER COLUMN "description" SET DATA TYPE VARCHAR(100);
ALTER TABLE "public"."cards" ALTER COLUMN "modifiedById" SET DATA TYPE VARCHAR(36);

-- Add new statistical columns to player_cards
ALTER TABLE "public"."player_cards" ADD COLUMN IF NOT EXISTS "total_damage_done" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "public"."player_cards" ADD COLUMN IF NOT EXISTS "total_damage_taken" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "public"."player_cards" ADD COLUMN IF NOT EXISTS "total_wins" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "public"."player_cards" ALTER COLUMN "modifiedById" SET DATA TYPE VARCHAR(36);

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_modifiedById_fkey" FOREIGN KEY ("modifiedById") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_cards" ADD CONSTRAINT "player_cards_card_acquisition_type_id_fkey" FOREIGN KEY ("card_acquisition_type_id") REFERENCES "public"."card_acquisition_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
