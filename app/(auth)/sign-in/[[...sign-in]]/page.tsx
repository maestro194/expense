import { SignIn } from "@clerk/nextjs";

export default function Page() {
  return (
		<div className="min-h-screen grid grid-cols-1 lg:grid-cols-2">	
			<div className="justify-center items-center h-full px-4 flex flex-col">
			 	<SignIn path="/sign-in" />
			</div>
		</div>
	);
}