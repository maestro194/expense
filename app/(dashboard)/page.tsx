import { Button } from "@/components/ui/button";
import { UserButton } from "@clerk/nextjs";

export default function Home() {
  return (
    <div>
      <Button>This is an authenticated</Button>

      <UserButton afterSignOutUrl="/"/>
    </div>
  );
}
