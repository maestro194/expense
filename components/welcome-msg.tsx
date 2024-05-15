import { useUser } from '@clerk/nextjs';

const WelcomeMsg = () => {
    const {user, isLoaded} = useUser();

    return (
        <div className='space-y-2 mb-4'>
            <h2 className='text-2xl lg:text-4xl text-white font-medium'>
                Welcome back{isLoaded ? ", " : ""}  {user ? (user.fullName) : ''}
            </h2>
            <p className='text-[#3a598a] text-sm lg:text-base'>
                This is your spending reports
            </p>
        </div>
    );
}

export default WelcomeMsg;