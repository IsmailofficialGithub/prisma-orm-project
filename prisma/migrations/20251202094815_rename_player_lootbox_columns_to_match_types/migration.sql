/*
  Rename player lootbox columns to match lootbox type names (preserving existing data)
  - basic_lootbox_opened → common_lootbox_opened
  - premium_lootbox_opened → rare_lootbox_opened  
  - basic_pity_counter → common_pity_counter
  - premium_pity_counter → rare_pity_counter
  - Add new legendary columns for legendary lootbox type
*/

-- Rename existing columns to match lootbox type names
ALTER TABLE "public"."players" RENAME COLUMN "basic_lootbox_opened" TO "common_lootbox_opened";
ALTER TABLE "public"."players" RENAME COLUMN "premium_lootbox_opened" TO "rare_lootbox_opened";
ALTER TABLE "public"."players" RENAME COLUMN "basic_pity_counter" TO "common_pity_counter";
ALTER TABLE "public"."players" RENAME COLUMN "premium_pity_counter" TO "rare_pity_counter";

-- Add new columns for legendary lootbox type
ALTER TABLE "public"."players" ADD COLUMN "legendary_lootbox_opened" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "public"."players" ADD COLUMN "legendary_pity_counter" INTEGER NOT NULL DEFAULT 0;
