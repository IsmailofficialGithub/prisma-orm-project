/*
  Warnings:

  - The `status` column on the `orders` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `payment_intents` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `transactions` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "public"."OrderStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "public"."PaymentIntentStatus" AS ENUM ('PENDING', 'SUCCEEDED', 'FAILED', 'CANCELLED', 'REQUIRES_ACTION');

-- CreateEnum
CREATE TYPE "public"."TransactionStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED', 'REVERSED', 'CANCELLED');

-- AlterTable
ALTER TABLE "public"."orders" DROP COLUMN "status",
ADD COLUMN     "status" "public"."OrderStatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "public"."payment_intents" DROP COLUMN "status",
ADD COLUMN     "status" "public"."PaymentIntentStatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "public"."transactions" DROP COLUMN "status",
ADD COLUMN     "status" "public"."TransactionStatus" NOT NULL DEFAULT 'PENDING';
