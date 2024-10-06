import { WalletSelector } from "./WalletSelector.tsx";
import Image from "next/image";

export function Header() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[30vh] p-12 py-24 w-screen flex-wrap mb-12 relative">
      <Image src={"https://cdn.pixabay.com/photo/2019/10/30/16/42/rainbow-4589989_1280.jpg"} alt={"header pic"} width={1080} height={600} className="absolute top-0 left-0 h-full w-full -z-10 opacity-25 object-cover" />
      <div className="flex flex-col gap-5 items-center flex-wrap">
        <div className="text-6xl font-bold">Aptos BidVerse&reg;</div>
        <div className="text-base font-medium text-zinc-400 max-w-screen-sm text-center">
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. A, aspernatur cum eaque eius error et illo molestiae, possimus quaerat quas qui quisquam recusandae similique sint, soluta ullam veritatis! Iusto, repudiandae.
        </div>
        <WalletSelector />
      </div>
    </div>
  );
}
