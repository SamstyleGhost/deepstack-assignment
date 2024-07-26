import { Show } from "solid-js"
import { AuctionCard } from "../components"
import { useStateContext } from "../context";

const HomePage = () => {

  const { walletData, connectToMetamask } = useStateContext();


  return (
    <div class="w-full h-full flex justify-center">
      <div class="max-w-6xl w-full h-full">
        <div class="w-full flex justify-between">
          <h1 class="text-5xl">Assignment</h1>
          <div class="flex flex-col justify-center">
            <Show when={walletData()} fallback={<button onClick={connectToMetamask}>Connect to Metamask</button>}>
              <p>Address: {walletData()}</p>
            </Show>
          </div>
        </div>
        <div class="py-8">
          <p>Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis.</p>
        </div>
        <div class="w-full flex flex-col gap-4">
          <AuctionCard />
          <AuctionCard />
          <AuctionCard />
          <AuctionCard />
        </div>
      </div>
    </div>
  )
}

export default HomePage
