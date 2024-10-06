import React from "react";
import Image from "next/image";
import Link from "next/link";

const ProductCard = () => {
  return (
    <div className="flex flex-row gap-5 justify-between items-stretch">
      <Image src={"/"} width={400} height={400} alt={"ur mom"} className="w-60 bg-blue-300" />
      <div className="w-full relative">
        <div className="flex flex-wrap gap-2.5 items-center">
          <div className="font-semibold text-4xl"><Link href={"/"}>Product Title</Link></div>
          <div className="rounded-full bg-green-800 px-4 py-1 text-xs font-semibold uppercase">available</div>
        </div>
        <div className="font-lg text-zinc-500 font-medium mt-1">Open for bidding 01/05/1990 - 01/05/1889</div>
        <div className="text-base font-semibold text-zinc-400 max-w-96 truncate py-2 px-4 rounded-sm bg-zinc-800 mt-2.5 mb-24">#iddd</div>
        <div className="flex gap-5 items-end absolute bottom-0">
          <div className="text-6xl font-bold text-green-700">$2.00</div>
        </div>
      </div>
    </div>
  );
};

export default ProductCard;
