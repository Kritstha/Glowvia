<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: system-ui, -apple-system, sans-serif;
        background: #f5f5f5;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 20px;
    }

    .stat-number {
        font-size: 28px;
        font-weight: 600;
        color: #000;
    }

    .stat-label {
        font-size: 12px;
        color: #666;
        margin-top: 8px;
    }

    .card {
        background: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 30px;
    }

    .card-title {
        font-size: 16px;
        font-weight: 600;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        font-size: 12px;
        font-weight: 500;
        display: block;
        margin-bottom: 5px;
        color: #666;
    }

    input, select {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
    }

    button {
        background: #000;
        color: white;
        border: none;
        padding: 10px 16px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
    }

    button:hover {
        background: #333;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px 8px;
        text-align: left;
        border-bottom: 1px solid #eee;
        font-size: 14px;
    }

    th {
        font-size: 12px;
        font-weight: 600;
        color: #666;
        text-transform: uppercase;
    }

    .badge {
        display: inline-block;
        padding: 2px 8px;
        border-radius: 4px;
        font-size: 12px;
        background: #f0f0f0;
    }

    .work-progress {
        text-align: center;
        padding: 60px 20px;
        color: #999;
        font-style: italic;
        background: #fafafa;
        border-radius: 4px;
    }

    .dashboard-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 30px;
        margin-bottom: 30px;
    }

    .btn-small {
        background: none;
        color: #666;
        border: 1px solid #ddd;
        padding: 4px 12px;
        font-size: 12px;
        margin-right: 5px;
    }

    .btn-small:hover {
        background: #000;
        color: white;
        border-color: #000;
    }

    .btn-danger {
        background: none;
        color: #dc3545;
        border: 1px solid #ddd;
        padding: 4px 12px;
        font-size: 12px;
    }

    .btn-danger:hover {
        background: #dc3545;
        color: white;
        border-color: #dc3545;
    }

    hr {
        margin: 20px 0;
        border: none;
        border-top: 1px solid #eee;
    }
</style>

<div class="container">
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number">0</div>
            <div class="stat-label">total revenue</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">0</div>
            <div class="stat-label">total orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">0</div>
            <div class="stat-label">customers</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">0</div>
            <div class="stat-label">pending orders</div>
        </div>
    </div>

    <div class="dashboard-grid">
        <div class="card">
            <div class="card-title">add new product</div>
            <form>
                <div class="form-group">
                    <label>product name</label>
                    <input type="text" placeholder="e.g., Niacinamide Serum">
                </div>
                <div class="form-group">
                    <label>brand</label>
                    <input type="text" placeholder="e.g., The Ordinary">
                </div>
                <div class="form-group">
                    <label>category</label>
                    <input type="text" placeholder="e.g., Serum">
                </div>
                <div class="form-group">
                    <label>price</label>
                    <input type="text" placeholder="0.00">
                </div>
                <div class="form-group">
                    <label>stock</label>
                    <input type="text" placeholder="0">
                </div>
                <button type="button">add to inventory</button>
            </form>
        </div>

        <div class="card">
            <div class="card-title">recent orders</div>
            <div class="work-progress">orders module - work in progress</div>
        </div>
    </div>

    <div class="card">
        <div class="card-title">product inventory</div>
        <table>
            <thead>
                <tr><th>product</th><th>brand</th><th>price</th><th>stock</th><th>actions</th></tr>
            </thead>
            <tbody>
                <tr><td>Niacinamide Serum</td><td>The Ordinary</td><td>$29.99</td><td>45</td><td><button class="btn-small">edit</button> <button class="btn-danger">delete</button></td></tr>
                <tr><td>Hydrating Cleanser</td><td>CeraVe</td><td>$45.50</td><td>12</td><td><button class="btn-small">edit</button> <button class="btn-danger">delete</button></td></tr>
                <tr><td>Moisturizing Cream</td><td>CeraVe</td><td>$34.99</td><td>8</td><td><button class="btn-small">edit</button> <button class="btn-danger">delete</button></td></tr>
            </tbody>
        </table>
        <hr>
        <div class="work-progress" style="padding:20px;">✏edit/delete functionality - work in progress</div>
    </div>

    <div class="card">
        <div class="card-title">orders management</div>
        <div class="work-progress">order tracking, status updates, invoice generation - work in progress</div>
    </div>

    <div class="card">
        <div class="card-title">customer management</div>
        <div class="work-progress"> customer profiles, order history, preferences - work in progress</div>
    </div>

    <div class="card">
        <div class="card-title">analytics & reports</div>
        <div class="work-progress">sales reports, inventory analytics, customer insights - work in progress</div>
    </div>

    <div class="card">
        <div class="card-title">settings</div>
        <div class="work-progress">store settings, shipping methods, payment gateways - work in progress</div>
    </div>
</div>