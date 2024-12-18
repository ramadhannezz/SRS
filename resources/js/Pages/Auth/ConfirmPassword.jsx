import { useEffect } from 'react';
import GuestLayout from '@/Layouts/GuestLayout';
import InputError from '@/Components/InputError';
import InputLabel from '@/Components/InputLabel';
import PrimaryButton from '@/Components/PrimaryButton';
import { InputText } from 'primereact/inputtext'; // Gunakan PrimeReact InputText untuk konsistensi
import { Head, useForm } from '@inertiajs/react';
import '../../../css/login.css'; // Sesuaikan path ke CSS Anda

export default function ConfirmPassword() {
    const { data, setData, post, processing, errors, reset } = useForm({
        password: '',
    });

    useEffect(() => {
        return () => {
            reset('password');
        };
    }, []);

    const submit = (e) => {
        e.preventDefault();

        post(route('password.confirm'));
    };

    return (
        <GuestLayout>
            <Head title="Confirm Password" />

            <div className="login-background">
                <div className="login-container">
                    <div className="login-card">
                        <div className="text-center mb-5">
                            <div className="text-900 text-3xl font-medium mb-3">Confirm Password</div>
                            <span className="text-600 font-medium line-height-3">
                                This is a secure area of the application. Please confirm your password before continuing.
                            </span>
                        </div>
                        <form onSubmit={submit}>
                            <div className="mb-3">
                                <InputLabel
                                    htmlFor="password"
                                    value="Password"
                                    className="block text-900 font-medium mb-2"
                                />
                                <InputText
                                    id="password"
                                    type="password"
                                    placeholder="Enter your password"
                                    className="w-full"
                                    value={data.password}
                                    onChange={(e) => setData('password', e.target.value)}
                                />
                                <InputError message={errors.password} className="mt-2" />
                            </div>
                            <div className="mb-3">
                                <PrimaryButton
                                    className="w-full bg-indigo-600 hover:bg-indigo-700 text-white"
                                    disabled={processing}
                                >
                                    {processing ? 'Processing...' : 'Confirm Password'}
                                </PrimaryButton>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </GuestLayout>
    );
}
