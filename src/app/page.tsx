"use client";

import { Header } from "@/components/aptos/Header.tsx";
// import { useWallet } from "@aptos-labs/wallet-adapter-react";
import ProductCard from "@/components/ProductCard.tsx";

const products = [0, 1, 2, 3, 4];

function App() {
  // const { connected } = useWallet();

  return (
    <>
      <Header />
      <div className="flex flex-col items-center justify-center">
        <div className="flex items-center justify-center flex-wrap gap-12 m-5">
          {products.map(el => (
            <ProductCard key={el} />
          ))}
        </div>
      </div>
    </>
  );
}

export default App;
