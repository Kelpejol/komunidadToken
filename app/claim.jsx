"use client"
import { Button } from "@/components/ui/button";


import  handleInteraction from "@/utils/ethereum";

export default function ButtonComponent () {

  return (
    <div>

      <Button onClick={handleInteraction}>Claim</Button>
    </div>
  );
}
