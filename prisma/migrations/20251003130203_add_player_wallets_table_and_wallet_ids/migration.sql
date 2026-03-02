-- AlterTable
ALTER TABLE "public"."players" ADD COLUMN     "walletIds" TEXT[];

-- CreateTable
CREATE TABLE "public"."player_wallets" (
    "id" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "player_wallets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."_PlayerWallets" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_PlayerWallets_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "player_wallets_address_key" ON "public"."player_wallets"("address");

-- CreateIndex
CREATE INDEX "_PlayerWallets_B_index" ON "public"."_PlayerWallets"("B");

-- AddForeignKey
ALTER TABLE "public"."_PlayerWallets" ADD CONSTRAINT "_PlayerWallets_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_PlayerWallets" ADD CONSTRAINT "_PlayerWallets_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."player_wallets"("id") ON DELETE CASCADE ON UPDATE CASCADE;
