import { useEffect } from 'react';
import GuestLayout from '@/Layouts/GuestLayout';
import InputError from '@/Components/InputError';
import InputLabel from '@/Components/InputLabel';
import PrimaryButton from '@/Components/PrimaryButton';
import { InputText } from 'primereact/inputtext'; // Menggunakan InputText untuk konsistensi
import { Head, useForm } from '@inertiajs/react';
import '../../../css/login.css'; // Sesuaikan path ke CSS Anda

export default function ResetPassword({ token, email }) {
    const { data, setData, post, processing, errors, reset } = useForm({
        token: token,
        email: email,
        password: '',
        password_confirmation: '',
    });

    useEffect(() => {
        return () => {
            reset('password', 'password_confirmation');
        };
    }, []);

    const submit = (e) => {
        e.preventDefault();

        post(route('password.store'));
    };

    return (
        <GuestLayout>
            <Head title="Reset Password" />

            <div className="login-background">
                <div className="login-container">
                    <div className="login-card">
                        <div className="text-center mb-5">
                            <div className="text-900 text-3xl font-medium mb-3">Reset Password</div>
                            <span className="text-600 font-medium line-height-3">
                                Enter your new password below to reset your account password.
                            </span>
                        </div>
                        <form onSubmit={submit}>
                            <div className="mb-3">
                                <InputLabel
                                    htmlFor="email"
                                    value="Email"
                                    className="block text-900 font-medium mb-2"
                                />
                                <InputText
                                    id="email"
                                    type="email"
                                    placeholder="Enter your email"
                                    className="w-full"
                                    value={data.email}
                                    autoComplete="username"
                                    onChange={(e) => setData('email', e.target.value)}
                                />
                                <InputError message={errors.email} className="mt-2" />
                            </div>

                            <div className="mb-3">
                                <InputLabel
                                    htmlFor="password"
                                    value="New Password"
                                    className="block text-900 font-medium mb-2"
                                />
                                <InputText
                                    id="password"
                                    type="password"
                                    placeholder="Enter new password"
                                    className="w-full"
                                    value={data.password}
                                    autoComplete="new-password"
                                    onChange={(e) => setData('password', e.target.value)}
                                />
                                <InputError message={errors.password} className="mt-2" />
                            </div>

                            <div className="mb-3">
                                <InputLabel
                                    htmlFor="password_confirmation"
                                    value="Confirm Password"
                                    className="block text-900 font-medium mb-2"
                                />
                                <InputText
                                    id="password_confirmation"
                                    type="password"
                                    placeholder="Confirm new password"
                                    className="w-full"
                                    value={data.password_confirmation}
                                    autoComplete="new-password"
                                    onChange={(e) => setData('password_confirmation', e.target.value)}
                                />
                                <InputError message={errors.password_confirmation} className="mt-2" />
                            </div>

                            <div className="mb-3">
                                <PrimaryButton
                                    className="w-full bg-indigo-600 hover:bg-indigo-700 text-white"
                                    disabled={processing}
                                >
                                    {processing ? 'Processing...' : 'Reset Password'}
                                </PrimaryButton>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </GuestLayout>
    );
}
