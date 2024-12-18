import { useEffect, useState } from 'react';
import GuestLayout from '@/Layouts/GuestLayout';
import InputError from '@/Components/InputError';
import InputLabel from '@/Components/InputLabel';
import PrimaryButton from '@/Components/PrimaryButton';
import {InputText} from "primereact/inputtext";
import TextInput from '@/Components/TextInput';
import { Head, Link, useForm } from '@inertiajs/react';
import axios from 'axios';
import '../../../css/login.css'; // Sesuaikan path ke CSS Anda

export default function ForgotPassword({ status }) {
    const { data, setData, post, processing, errors, reset } = useForm({
        email: '',
        captcha: '',
    });

    const [captchaSrc, setCaptchaSrc] = useState('');

    const fetchCaptcha = async () => {
        try {
            const response = await axios.get('/random-captcha');
            setCaptchaSrc(response.data.captcha);
        } catch (error) {
            console.error('Error fetching captcha:', error);
        }
    };

    useEffect(() => {
        fetchCaptcha();
        return () => reset('captcha');
    }, []);

    const submit = (e) => {
        e.preventDefault();
        post(route('password.email'), {
            onError: fetchCaptcha, // Refresh captcha jika ada error
        });
    };

    return (
        <GuestLayout>
            <Head title="Forgot Password" />

            <div className="login-background">
                <div className="login-container">
                    <div className="login-card">
                        <div className="text-center mb-5">
                            <div className="text-900 text-3xl font-medium mb-3">Forgot Password</div>
                            <span className="text-600 font-medium line-height-3">
                                Enter your email address, and we'll send you instructions to reset your password.
                            </span>
                        </div>
                        {status && (
                            <div
                                className="p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg"
                                role="alert"
                            >
                                {status}
                            </div>
                        )}
                        <form onSubmit={submit}>
                            <div>
                                <div className="mb-3">
                                    <InputLabel
                                        htmlFor="email"
                                        value="Email Address"
                                        className="block text-900 font-medium mb-2"
                                    />
                                    <InputText
                                        id="email"
                                        type="text"
                                        placeholder="Email address"
                                        className="w-full"
                                        value={data.email}
                                        onChange={(e) => setData('email', e.target.value)}
                                    />
                                    <InputError message={errors.email} className="" />
                                </div>
                                <div className="mb-3">
                                    <InputLabel
                                        htmlFor="captcha"
                                        value="Captcha"
                                        className="block text-900 font-medium mb-2"
                                    />
                                    <img
                                        src={captchaSrc}
                                        alt="Captcha"
                                        className="mb-3"
                                        onClick={fetchCaptcha}
                                        style={{ cursor: 'pointer' }}
                                    />
                                    <InputText
                                        id="captcha"
                                        type="text"
                                        placeholder="Enter the text from the image"
                                        className="w-full"
                                        value={data.captcha}
                                        onChange={(e) => setData('captcha', e.target.value)}
                                    />
                                    <InputError message={errors.captcha} className="" />
                                </div>
                                <div className="mb-3">
                                    <PrimaryButton
                                        className="w-full bg-indigo-600 hover:bg-indigo-700 text-white"
                                        disabled={processing}
                                    >
                                        {processing ? 'Sending...' : 'Send Password Reset Link'}
                                    </PrimaryButton>
                                </div>
                                <div className="text-center mt-4">
                                    <Link
                                        href={route('login')}
                                        className="text-indigo-600 hover:text-indigo-800 text-sm font-medium"
                                    >
                                        Back to Login
                                    </Link>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </GuestLayout>
    );
}
