/*
  Warnings:

  - You are about to drop the column `loopCredits` on the `players` table. All the data in the column will be lost.

*/

-- First, migrate existing loopCredits data to currencies table
-- Insert or update Loop Credits (currency_type_id = 1) for each player
INSERT INTO "public"."currencies" ("id", "playerId", "currencyTypeId", "amount", "createdAt", "updatedAt")
SELECT 
    gen_random_uuid() as "id",
    p.id as "playerId",
    1 as "currencyTypeId", -- Loop Credits currency type
    p."loopCredits" as "amount",
    NOW() as "createdAt",
    NOW() as "updatedAt"
FROM "public"."players" p
WHERE p."loopCredits" > 0
ON CONFLICT ("playerId", "currencyTypeId") 
DO UPDATE SET 
    "amount" = EXCLUDED."amount",
    "updatedAt" = NOW();

-- Also insert 0 amount records for players with 0 loopCredits to ensure consistency
INSERT INTO "public"."currencies" ("id", "playerId", "currencyTypeId", "amount", "createdAt", "updatedAt")
SELECT 
    gen_random_uuid() as "id",
    p.id as "playerId",
    1 as "currencyTypeId", -- Loop Credits currency type
    0 as "amount",
    NOW() as "createdAt",
    NOW() as "updatedAt"
FROM "public"."players" p
WHERE p."loopCredits" = 0
ON CONFLICT ("playerId", "currencyTypeId") 
DO NOTHING; -- Don't overwrite existing records

-- Now drop the loopCredits column from players table
ALTER TABLE "public"."players" DROP COLUMN "loopCredits";
