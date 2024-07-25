const AuctionCard = () => {
  return (
    <div class="w-full rounded-xl border border-primary bg-primary text-background p-2">
      <h4 class="text-xl">Item name</h4>
      <div class="flex gap-4 items-center">
        <p class="text-xs">Owner: </p>
        <h6>Owner address</h6>
      </div>
    </div>
  )
}

export default AuctionCard
