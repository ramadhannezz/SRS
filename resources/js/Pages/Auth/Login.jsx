import { useEffect, useState } from 'react';
import GuestLayout from '@/Layouts/GuestLayout';
import InputError from '@/Components/InputError';
import InputLabel from '@/Components/InputLabel';
import PrimaryButton from '@/Components/PrimaryButton';
import TextInput from '@/Components/TextInput';
import {Head, Link, useForm} from '@inertiajs/react';
import {InputText} from "primereact/inputtext";
import {Checkbox} from "primereact/checkbox";
import {Button} from "primereact/button";
import '../../../css/login.css'; // Path relatif ke file login.css
import axios from 'axios'; // Tambahkan axios untuk melakukan request HTTP

export default function Login({status, canResetPassword}) {
    const {data, setData, post, processing, errors, reset} = useForm({
        email: '',
        password: '',
        remember: false,
        captcha: ''
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
        return () => {
            reset('password');
        };
    }, []);

    const submit = (e) => {
        e.preventDefault();
        post(route('login'), {
            onError: () => {
                // Refresh captcha jika ada error
                fetchCaptcha();
            }
        });
    };
    return (
        <GuestLayout>
            <Head title="Log in"/>

            {status && <div className="mb-4 font-medium text-sm text-green-600">{status}</div>}

            <div className="login-background">
                <div className="login-container">
                    <img src="/images/logo/-dark.svg" alt="hyper" height={50} className="mb-3 logo"/>
                    <div className="login-card">
                        <div className="text-center mb-5">
                            <div className="text-900 text-3xl font-medium mb-3">Welcome Back!</div>
                            <span className="text-600 font-medium line-height-3">Don't have an account?</span>
                            <Link href={route('register')} className="font-medium no-underline ml-2 text-blue-500 cursor-pointer">Create here!</Link>
                        </div>
                        <form onSubmit={submit}>
                            <div>
                                <div className="mb-3">
                                    <label htmlFor="email" className="block text-900 font-medium mb-2">Email</label>
                                    <InputText
                                        id="email"
                                        type="text"
                                        placeholder="Email address"
                                        className="w-full"
                                        value={data.email}
                                        onChange={(e) => setData('email', e.target.value)}
                                    />
                                    <InputError message={errors.email} className=""/>
                                </div>
                                <div className="mb-3">
                                    <label htmlFor="password" className="block text-900 font-medium mb-2">Password</label>
                                    <InputText
                                        id="password"
                                        type="password"
                                        placeholder="Password"
                                        className="w-full"
                                        value={data.password}
                                        onChange={(e) => setData('password', e.target.value)}
                                    />
                                    <InputError message={errors.password} className=""/>
                                </div>

                                <div className="mb-3">
                                    <label htmlFor="captcha" className="block text-900 font-medium mb-2">Captcha</label>
                                    <img src={captchaSrc} alt="Captcha" className="mb-3" onClick={fetchCaptcha} style={{cursor: 'pointer'}}/>
                                    <InputText
                                        id="captcha"
                                        type="text"
                                        placeholder="Enter the text from the image"
                                        className="w-full"
                                        value={data.captcha}
                                        onChange={(e) => setData('captcha', e.target.value)}
                                    />
                                    <InputError message={errors.captcha} className=""/>
                                </div>
                                
                                <div className="mb-3">
                                {canResetPassword && (
                                    <Link
                                        href={route('password.request')}
                                        className="font-medium no-underline ml-2 text-blue-500 text-right cursor-pointer"
                                    >
                                        Forgot your password?
                                    </Link>
                                )}
                                </div>
                                <PrimaryButton label="Sign In" className="w-full" disabled={processing}/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </GuestLayout>
    );
}
