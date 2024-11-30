export default function Guest({ children }) {
    return (
        <div className="min-h-screen flex flex-col sm:justify-center items-center ">

            <div className="w-full sm:max-w-md my-auto  ">
                {children}
            </div>
        </div>
    );
}
