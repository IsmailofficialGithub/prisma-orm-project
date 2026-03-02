-- AlterTable
ALTER TABLE "public"."players" 
ADD COLUMN     "basic_lootbox_opened" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "basic_pity_counter" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "premium_lootbox_opened" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "premium_pity_counter" INTEGER NOT NULL DEFAULT 0;
