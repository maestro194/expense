import Link from 'next/link';
import Image from 'next/image';

const HeaderLogo = () => {
    return (
        <Link href="/">
            <div className='items-center hidden lg:flex'>
                <Image src="../next.svg" alt="Logo" width={32} height={32} />
                <p className='font-bold text-white text-2xl ml-2.5'>
                    Expense
                </p>
            </div>
        </Link>
    )
}

export default HeaderLogo;