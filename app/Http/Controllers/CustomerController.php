<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Log;

class CustomerController extends Controller
{
    public function index()
    {
        $customers = Customer::all();
        return Inertia::render('MasterData/CustomerPage', [
            'customers' => $customers,
        ]);
    }

    public function store(Request $request)
{
    $validatedData = $request->validate([
        'name' => 'required|string|max:255',
        'email' => 'required|string|email|max:255|unique:customers',
        'phone' => 'required|string|max:15|unique:customers',
    ]);

    Log::info('Validated Data:', $validatedData);

    Customer::create($validatedData);

    return redirect()->route('customer.index')->with('success', 'Customer created successfully.');
}


    public function update(Request $request, Customer $customer)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:customers,email,' . $customer->id,
            'phone' => 'required|string|max:15|unique:customers,phone,' . $customer->id,
        ]);

        $customer->update($request->all());

        return redirect()->route('customer.index')->with('success', 'Customer updated successfully.');
    }

    public function destroy(Customer $customer)
    {
        $customer->delete();

        return redirect()->route('customer.index')->with('success', 'Customer deleted successfully.');
    }
}
