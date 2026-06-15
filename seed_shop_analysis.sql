-- Seed file for Zara Shop Analysis and Dashboard
BEGIN;

-- 1. Ensure Mall, Category, Shop exist
INSERT INTO public.mall (mall_id, name, location, created_at)
VALUES ('22222222-0000-0000-0000-000000000001', 'Maka Mall', 'Amman, Jordan', '2026-05-01 10:00:00+00')
ON CONFLICT (mall_id) DO NOTHING;
INSERT INTO public.category (category_id, name, created_at)
VALUES ('55555555-0000-0000-0000-000000000001', 'Fashion & Apparel', '2026-05-01 10:00:00+00')
ON CONFLICT (category_id) DO NOTHING;
INSERT INTO public.shop (shop_id, name, mall_id, category_id, is_active, created_at, bio, website_url, social_links)
VALUES ('66666666-0000-0000-0000-000000000001', 'Zara', '22222222-0000-0000-0000-000000000001', '55555555-0000-0000-0000-000000000001', true, '2026-05-01 12:00:00+00', 
        'The latest trends in clothing and accessories for women, men, and kids.', 
        'https://www.zara.com', 
        '{"facebook": "ZaraJordan", "instagram": "@zarajordan"}')
ON CONFLICT (shop_id) DO NOTHING;
INSERT INTO public.shop_points_wallet (shop_id, points_received)
VALUES ('66666666-0000-0000-0000-000000000001', 100000)
ON CONFLICT (shop_id) DO NOTHING;

-- 2. Seed Users and Points Balances
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000001', 'ahmad@example.com', 'Ahmad', 'Al-Momani', 'Male', '0791234561', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000001', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000001', '99999999-0000-0000-0000-000000000001', 408, 1705, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000002', 'rania@example.com', 'Rania', 'Haddad', 'Female', '0791234562', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000002', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000002', '99999999-0000-0000-0000-000000000002', 3146, 3444, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000003', 'omar@example.com', 'Omar', 'Shaker', 'Male', '0791234563', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000003', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000003', '99999999-0000-0000-0000-000000000003', 2404, 3253, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000004', 'leila@example.com', 'Leila', 'Kawar', 'Female', '0791234564', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000004', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000004', '99999999-0000-0000-0000-000000000004', 2062, 2623, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000005', 'tariq@example.com', 'Tariq', 'Masri', 'Male', '0791234565', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000001', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000005', '99999999-0000-0000-0000-000000000005', 4280, 7174, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000006', 'farah@example.com', 'Farah', 'Jaber', 'Female', '0791234566', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000002', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000006', '99999999-0000-0000-0000-000000000006', 3474, 3869, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000007', 'youssef@example.com', 'Youssef', 'Naber', 'Male', '0791234567', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000003', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000007', '99999999-0000-0000-0000-000000000007', 995, 1357, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000008', 'yasmin@example.com', 'Yasmin', 'Halaby', 'Female', '0791234568', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000004', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000008', '99999999-0000-0000-0000-000000000008', 3175, 5686, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000009', 'ziad@example.com', 'Ziad', 'Kanaan', 'Male', '0791234569', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000001', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000009', '99999999-0000-0000-0000-000000000009', 966, 1207, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user (user_id, email, first_name, last_name, gender, phone, password_hash, tier_id, created_at)
VALUES ('99999999-0000-0000-0000-000000000010', 'noor@example.com', 'Noor', 'Dajani', 'Female', '0791234570', 'a2/ZvxH6.1N5hG9Z7pTeeGg7Rve/Bq0d2sL3iHn8o/x7h5y9z5u2', '11111111-0000-0000-0000-000000000002', '2026-05-01 15:00:00+00')
ON CONFLICT (user_id) DO NOTHING;
INSERT INTO public.user_points_balance (user_points_balance_id, user_id, total_points, lifetime_points, last_updated)
VALUES ('88888888-0000-0000-0000-000000000010', '99999999-0000-0000-0000-000000000010', 2466, 5358, '2026-06-02 18:00:00+00')
ON CONFLICT (user_id) DO NOTHING;

-- 3. Seed Offers
INSERT INTO public.offer (offer_id, name, description, reward_type, reward_value, is_active, shop_id, start_date, end_date, created_at)
VALUES ('33333333-0000-0000-0000-000000000001', '10% Off Summer Dress Collection', 'Get 10% off on all summer dresses.', 'Discount', '{"discount_percent": 10}', true, '66666666-0000-0000-0000-000000000001', '2026-05-01 00:00:00+00', '2027-05-01 00:00:00+00', '2026-05-01 12:00:00+00')
ON CONFLICT (offer_id) DO NOTHING;
INSERT INTO public.offer (offer_id, name, description, reward_type, reward_value, is_active, shop_id, start_date, end_date, created_at)
VALUES ('33333333-0000-0000-0000-000000000002', 'Buy 2 Get 1 Free Basics', 'Buy two basic t-shirts and get one free.', 'BOGO', '{"buy": 2, "get": 1}', true, '66666666-0000-0000-0000-000000000001', '2026-05-01 00:00:00+00', '2027-05-01 00:00:00+00', '2026-05-01 12:00:00+00')
ON CONFLICT (offer_id) DO NOTHING;
INSERT INTO public.offer (offer_id, name, description, reward_type, reward_value, is_active, shop_id, start_date, end_date, created_at)
VALUES ('33333333-0000-0000-0000-000000000003', 'Free Accessories on 100 JOD Spend', 'Spend 100 JOD or more and get a free belt or sunglasses.', 'FreeGift', '{"gift": "accessories"}', false, '66666666-0000-0000-0000-000000000001', '2026-05-01 00:00:00+00', '2027-05-01 00:00:00+00', '2026-05-01 12:00:00+00')
ON CONFLICT (offer_id) DO NOTHING;

-- 4. Seed Stamps
INSERT INTO public.stamp (stamp_id, name, description, reward_type, stamps_required, stamp_icon_url, is_active, shop_id, start_date, end_date, created_at)
VALUES ('44444444-0000-0000-0000-000000000001', 'Zara Denim Loyalty Stamp', 'Collect 10 stamps on denim products to get a free jeans coupon.', 'Free Denim', 10, 'local_offer', true, '66666666-0000-0000-0000-000000000001', '2026-05-01 00:00:00+00', '2027-05-01 00:00:00+00', '2026-05-01 12:00:00+00')
ON CONFLICT (stamp_id) DO NOTHING;
INSERT INTO public.stamp (stamp_id, name, description, reward_type, stamps_required, stamp_icon_url, is_active, shop_id, start_date, end_date, created_at)
VALUES ('44444444-0000-0000-0000-000000000002', 'Zara Winter Card', 'Earn stamps for winter jacket purchases.', '20 JOD Voucher', 5, 'ac_unit', false, '66666666-0000-0000-0000-000000000001', '2026-05-01 00:00:00+00', '2027-05-01 00:00:00+00', '2026-05-01 12:00:00+00')
ON CONFLICT (stamp_id) DO NOTHING;

-- 5. Seed Earn & Redeem Transactions (30-day timeline)
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0000-0000', 96.84, 'JOD', 96, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-06-02-0', '99999999-0000-0000-0000-000000000010', '2026-06-02 13:30:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0000-0001', 77.29, 'JOD', 77, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-06-02-1', '99999999-0000-0000-0000-000000000005', '2026-06-02 18:52:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0000-0002', 124.12, 'JOD', 124, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-06-02-2', '99999999-0000-0000-0000-000000000009', '2026-06-02 16:01:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0000-0003', 112.37, 'JOD', 112, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-06-02-3', '99999999-0000-0000-0000-000000000005', '2026-06-02 15:07:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0000-0000', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000008', '214610', '2026-06-02 11:42:00+00', '2026-06-02 11:42:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0000-0001', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000003', '210824', '2026-06-02 17:23:00+00', '2026-06-02 17:23:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0001-0000', 37.83, 'JOD', 37, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-06-01-0', '99999999-0000-0000-0000-000000000002', '2026-06-01 15:21:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0001-0001', 33.15, 'JOD', 33, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-06-01-1', '99999999-0000-0000-0000-000000000007', '2026-06-01 12:00:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0001-0002', 105.94, 'JOD', 105, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-06-01-2', '99999999-0000-0000-0000-000000000006', '2026-06-01 11:48:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0001-0003', 66.95, 'JOD', 66, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-06-01-3', '99999999-0000-0000-0000-000000000002', '2026-06-01 16:09:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0001-0000', 20.0, 'JOD', 10.0, 200, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000004', '804188', '2026-06-01 15:23:00+00', '2026-06-01 15:23:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0002-0000', 100.62, 'JOD', 100, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-31-0', '99999999-0000-0000-0000-000000000003', '2026-05-31 20:31:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0002-0001', 73.0, 'JOD', 73, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-31-1', '99999999-0000-0000-0000-000000000003', '2026-05-31 18:08:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0002-0000', 20.0, 'JOD', 10.0, 200, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000001', '368516', '2026-05-31 18:20:00+00', '2026-05-31 18:20:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0003-0000', 88.11, 'JOD', 88, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-30-0', '99999999-0000-0000-0000-000000000009', '2026-05-30 11:19:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0003-0001', 30.4, 'JOD', 30, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-30-1', '99999999-0000-0000-0000-000000000003', '2026-05-30 16:03:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0003-0002', 27.94, 'JOD', 27, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-30-2', '99999999-0000-0000-0000-000000000005', '2026-05-30 11:18:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0003-0000', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000004', '335540', '2026-05-30 11:53:00+00', '2026-05-30 11:53:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0004-0000', 101.75, 'JOD', 101, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-29-0', '99999999-0000-0000-0000-000000000007', '2026-05-29 17:50:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0004-0001', 80.43, 'JOD', 80, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-29-1', '99999999-0000-0000-0000-000000000001', '2026-05-29 11:39:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0004-0000', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000005', '847887', '2026-05-29 14:09:00+00', '2026-05-29 14:09:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0005-0000', 123.3, 'JOD', 123, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-28-0', '99999999-0000-0000-0000-000000000004', '2026-05-28 13:00:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0005-0001', 102.09, 'JOD', 102, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-28-1', '99999999-0000-0000-0000-000000000008', '2026-05-28 16:03:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0005-0002', 147.36, 'JOD', 147, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-28-2', '99999999-0000-0000-0000-000000000002', '2026-05-28 17:07:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0005-0003', 80.55, 'JOD', 80, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-28-3', '99999999-0000-0000-0000-000000000001', '2026-05-28 18:55:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0005-0000', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000002', '675880', '2026-05-28 16:40:00+00', '2026-05-28 16:40:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0006-0000', 91.88, 'JOD', 91, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-27-0', '99999999-0000-0000-0000-000000000009', '2026-05-27 20:32:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0006-0001', 25.94, 'JOD', 25, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-27-1', '99999999-0000-0000-0000-000000000003', '2026-05-27 11:43:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0006-0000', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000002', '993399', '2026-05-27 14:54:00+00', '2026-05-27 14:54:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0007-0000', 105.94, 'JOD', 105, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-26-0', '99999999-0000-0000-0000-000000000009', '2026-05-26 17:00:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0007-0001', 51.55, 'JOD', 51, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-26-1', '99999999-0000-0000-0000-000000000004', '2026-05-26 12:14:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0007-0002', 79.98, 'JOD', 79, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-26-2', '99999999-0000-0000-0000-000000000008', '2026-05-26 16:31:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0007-0003', 106.27, 'JOD', 106, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-26-3', '99999999-0000-0000-0000-000000000008', '2026-05-26 10:41:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0007-0000', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000003', '224413', '2026-05-26 14:31:00+00', '2026-05-26 14:31:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0007-0001', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000005', '182096', '2026-05-26 20:24:00+00', '2026-05-26 20:24:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0008-0000', 121.85, 'JOD', 121, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-25-0', '99999999-0000-0000-0000-000000000002', '2026-05-25 17:37:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0008-0001', 67.63, 'JOD', 67, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-25-1', '99999999-0000-0000-0000-000000000003', '2026-05-25 17:11:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0008-0002', 21.65, 'JOD', 21, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-25-2', '99999999-0000-0000-0000-000000000010', '2026-05-25 12:58:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0008-0000', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000005', '101324', '2026-05-25 19:40:00+00', '2026-05-25 19:40:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0008-0001', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000009', '238414', '2026-05-25 15:24:00+00', '2026-05-25 15:24:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0009-0000', 20.4, 'JOD', 20, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-24-0', '99999999-0000-0000-0000-000000000003', '2026-05-24 18:20:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0009-0001', 95.02, 'JOD', 95, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-24-1', '99999999-0000-0000-0000-000000000001', '2026-05-24 20:02:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0009-0002', 134.92, 'JOD', 134, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-24-2', '99999999-0000-0000-0000-000000000003', '2026-05-24 14:28:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0009-0003', 105.99, 'JOD', 105, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-24-3', '99999999-0000-0000-0000-000000000006', '2026-05-24 18:31:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0009-0000', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000007', '312887', '2026-05-24 15:23:00+00', '2026-05-24 15:23:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0010-0000', 41.15, 'JOD', 41, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-23-0', '99999999-0000-0000-0000-000000000002', '2026-05-23 12:21:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0010-0001', 93.37, 'JOD', 93, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-23-1', '99999999-0000-0000-0000-000000000007', '2026-05-23 11:17:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0010-0000', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000007', '537470', '2026-05-23 12:46:00+00', '2026-05-23 12:46:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0011-0000', 124.28, 'JOD', 124, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-22-0', '99999999-0000-0000-0000-000000000003', '2026-05-22 10:01:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0011-0001', 61.56, 'JOD', 61, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-22-1', '99999999-0000-0000-0000-000000000001', '2026-05-22 18:07:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0011-0002', 120.89, 'JOD', 120, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-22-2', '99999999-0000-0000-0000-000000000007', '2026-05-22 16:37:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0011-0003', 69.89, 'JOD', 69, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-22-3', '99999999-0000-0000-0000-000000000010', '2026-05-22 20:14:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0011-0000', 20.0, 'JOD', 10.0, 200, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000010', '750043', '2026-05-22 11:06:00+00', '2026-05-22 11:06:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0011-0001', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000003', '163312', '2026-05-22 14:34:00+00', '2026-05-22 14:34:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0012-0000', 71.88, 'JOD', 71, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-21-0', '99999999-0000-0000-0000-000000000003', '2026-05-21 11:19:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0012-0001', 64.85, 'JOD', 64, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-21-1', '99999999-0000-0000-0000-000000000004', '2026-05-21 15:06:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0012-0002', 69.98, 'JOD', 69, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-21-2', '99999999-0000-0000-0000-000000000008', '2026-05-21 10:05:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0012-0000', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000009', '276188', '2026-05-21 12:46:00+00', '2026-05-21 12:46:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0013-0000', 129.25, 'JOD', 129, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-20-0', '99999999-0000-0000-0000-000000000007', '2026-05-20 16:25:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0013-0001', 148.9, 'JOD', 148, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-20-1', '99999999-0000-0000-0000-000000000010', '2026-05-20 20:39:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0013-0000', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000003', '844772', '2026-05-20 14:57:00+00', '2026-05-20 14:57:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0014-0000', 42.42, 'JOD', 42, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-19-0', '99999999-0000-0000-0000-000000000008', '2026-05-19 18:30:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0014-0001', 77.8, 'JOD', 77, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-19-1', '99999999-0000-0000-0000-000000000006', '2026-05-19 11:34:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0014-0000', 20.0, 'JOD', 10.0, 200, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000002', '936798', '2026-05-19 20:52:00+00', '2026-05-19 20:52:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0015-0000', 133.35, 'JOD', 133, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-18-0', '99999999-0000-0000-0000-000000000010', '2026-05-18 20:57:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0015-0001', 124.42, 'JOD', 124, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-18-1', '99999999-0000-0000-0000-000000000004', '2026-05-18 12:36:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0015-0000', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000004', '174853', '2026-05-18 11:34:00+00', '2026-05-18 11:34:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0015-0001', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000007', '778913', '2026-05-18 12:29:00+00', '2026-05-18 12:29:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0016-0000', 109.07, 'JOD', 109, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-17-0', '99999999-0000-0000-0000-000000000009', '2026-05-17 14:24:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0016-0001', 134.49, 'JOD', 134, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-17-1', '99999999-0000-0000-0000-000000000002', '2026-05-17 17:59:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0016-0000', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000008', '561050', '2026-05-17 15:31:00+00', '2026-05-17 15:31:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0016-0001', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000008', '990739', '2026-05-17 21:38:00+00', '2026-05-17 21:38:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0017-0000', 68.29, 'JOD', 68, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-16-0', '99999999-0000-0000-0000-000000000010', '2026-05-16 10:14:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0017-0001', 106.13, 'JOD', 106, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-16-1', '99999999-0000-0000-0000-000000000008', '2026-05-16 19:10:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0017-0000', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000002', '701903', '2026-05-16 14:57:00+00', '2026-05-16 14:57:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0018-0000', 129.47, 'JOD', 129, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-15-0', '99999999-0000-0000-0000-000000000009', '2026-05-15 15:53:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0018-0001', 92.26, 'JOD', 92, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-15-1', '99999999-0000-0000-0000-000000000006', '2026-05-15 11:55:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0018-0002', 81.34, 'JOD', 81, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-15-2', '99999999-0000-0000-0000-000000000009', '2026-05-15 10:43:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0018-0000', 20.0, 'JOD', 10.0, 200, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000003', '625221', '2026-05-15 19:19:00+00', '2026-05-15 19:19:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0018-0001', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000010', '681890', '2026-05-15 20:06:00+00', '2026-05-15 20:06:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0019-0000', 122.8, 'JOD', 122, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-14-0', '99999999-0000-0000-0000-000000000003', '2026-05-14 13:25:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0019-0001', 43.53, 'JOD', 43, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-14-1', '99999999-0000-0000-0000-000000000003', '2026-05-14 13:23:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0019-0002', 61.8, 'JOD', 61, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-14-2', '99999999-0000-0000-0000-000000000005', '2026-05-14 11:38:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0019-0003', 124.24, 'JOD', 124, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-14-3', '99999999-0000-0000-0000-000000000002', '2026-05-14 20:58:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0019-0000', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000005', '448954', '2026-05-14 13:43:00+00', '2026-05-14 13:43:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0019-0001', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000010', '579734', '2026-05-14 21:46:00+00', '2026-05-14 21:46:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0020-0000', 32.76, 'JOD', 32, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-13-0', '99999999-0000-0000-0000-000000000003', '2026-05-13 10:25:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0020-0001', 133.88, 'JOD', 133, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-13-1', '99999999-0000-0000-0000-000000000005', '2026-05-13 10:18:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0020-0002', 69.2, 'JOD', 69, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-13-2', '99999999-0000-0000-0000-000000000004', '2026-05-13 16:15:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0020-0000', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000002', '935507', '2026-05-13 18:57:00+00', '2026-05-13 18:57:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0020-0001', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000002', '505470', '2026-05-13 12:46:00+00', '2026-05-13 12:46:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0021-0000', 79.43, 'JOD', 79, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-12-0', '99999999-0000-0000-0000-000000000008', '2026-05-12 10:33:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0021-0001', 127.62, 'JOD', 127, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-12-1', '99999999-0000-0000-0000-000000000002', '2026-05-12 15:41:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0021-0002', 121.98, 'JOD', 121, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-12-2', '99999999-0000-0000-0000-000000000010', '2026-05-12 17:25:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0021-0003', 90.04, 'JOD', 90, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-12-3', '99999999-0000-0000-0000-000000000001', '2026-05-12 12:09:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0021-0000', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000010', '661567', '2026-05-12 13:06:00+00', '2026-05-12 13:06:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0022-0000', 72.21, 'JOD', 72, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-11-0', '99999999-0000-0000-0000-000000000003', '2026-05-11 12:39:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0022-0001', 149.29, 'JOD', 149, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-11-1', '99999999-0000-0000-0000-000000000004', '2026-05-11 11:33:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0022-0002', 50.24, 'JOD', 50, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-11-2', '99999999-0000-0000-0000-000000000002', '2026-05-11 10:01:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0022-0000', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000005', '622624', '2026-05-11 11:42:00+00', '2026-05-11 11:42:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0023-0000', 92.39, 'JOD', 92, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-10-0', '99999999-0000-0000-0000-000000000004', '2026-05-10 11:52:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0023-0001', 78.24, 'JOD', 78, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-10-1', '99999999-0000-0000-0000-000000000004', '2026-05-10 10:12:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0023-0002', 23.7, 'JOD', 23, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-10-2', '99999999-0000-0000-0000-000000000003', '2026-05-10 16:45:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0023-0003', 146.55, 'JOD', 146, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-10-3', '99999999-0000-0000-0000-000000000003', '2026-05-10 11:41:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0023-0000', 20.0, 'JOD', 10.0, 200, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000010', '228386', '2026-05-10 11:43:00+00', '2026-05-10 11:43:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0024-0000', 96.26, 'JOD', 96, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-09-0', '99999999-0000-0000-0000-000000000003', '2026-05-09 17:11:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0024-0001', 119.6, 'JOD', 119, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-09-1', '99999999-0000-0000-0000-000000000001', '2026-05-09 18:23:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0024-0002', 118.02, 'JOD', 118, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-09-2', '99999999-0000-0000-0000-000000000002', '2026-05-09 19:15:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0024-0003', 101.24, 'JOD', 101, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-09-3', '99999999-0000-0000-0000-000000000004', '2026-05-09 16:32:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0024-0000', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000006', '409326', '2026-05-09 13:26:00+00', '2026-05-09 13:26:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0025-0000', 43.09, 'JOD', 43, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-08-0', '99999999-0000-0000-0000-000000000009', '2026-05-08 20:19:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0025-0001', 132.41, 'JOD', 132, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-08-1', '99999999-0000-0000-0000-000000000002', '2026-05-08 16:30:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0025-0002', 101.75, 'JOD', 101, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-08-2', '99999999-0000-0000-0000-000000000006', '2026-05-08 12:53:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0025-0003', 78.52, 'JOD', 78, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-08-3', '99999999-0000-0000-0000-000000000008', '2026-05-08 19:39:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0025-0000', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000003', '954543', '2026-05-08 18:16:00+00', '2026-05-08 18:16:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0025-0001', 20.0, 'JOD', 10.0, 200, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000001', '658576', '2026-05-08 13:49:00+00', '2026-05-08 13:49:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0026-0000', 59.19, 'JOD', 59, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-07-0', '99999999-0000-0000-0000-000000000004', '2026-05-07 16:23:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0026-0001', 94.46, 'JOD', 94, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-07-1', '99999999-0000-0000-0000-000000000004', '2026-05-07 13:18:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0026-0002', 22.82, 'JOD', 22, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-07-2', '99999999-0000-0000-0000-000000000004', '2026-05-07 12:04:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0026-0003', 50.53, 'JOD', 50, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-07-3', '99999999-0000-0000-0000-000000000006', '2026-05-07 11:02:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0026-0000', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000010', '882453', '2026-05-07 21:59:00+00', '2026-05-07 21:59:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0026-0001', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000003', '860820', '2026-05-07 21:38:00+00', '2026-05-07 21:38:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0027-0000', 49.24, 'JOD', 49, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-06-0', '99999999-0000-0000-0000-000000000010', '2026-05-06 20:39:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0027-0001', 52.39, 'JOD', 52, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-06-1', '99999999-0000-0000-0000-000000000002', '2026-05-06 12:32:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0027-0002', 45.9, 'JOD', 45, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-06-2', '99999999-0000-0000-0000-000000000005', '2026-05-06 17:13:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0027-0000', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000004', '711313', '2026-05-06 11:04:00+00', '2026-05-06 11:04:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0027-0001', 5.0, 'JOD', 10.0, 50, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000006', '677044', '2026-05-06 17:03:00+00', '2026-05-06 17:03:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0028-0000', 132.47, 'JOD', 132, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-05-0', '99999999-0000-0000-0000-000000000009', '2026-05-05 11:06:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0028-0001', 83.66, 'JOD', 83, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-05-1', '99999999-0000-0000-0000-000000000005', '2026-05-05 11:33:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0028-0000', 10.0, 'JOD', 10.0, 100, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000008', '718492', '2026-05-05 21:18:00+00', '2026-05-05 21:18:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0028-0001', 50.0, 'JOD', 10.0, 500, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000001', '534186', '2026-05-05 15:51:00+00', '2026-05-05 15:51:00+00')
ON CONFLICT (redeem_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0029-0000', 64.66, 'JOD', 64, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-04-0', '99999999-0000-0000-0000-000000000010', '2026-05-04 19:04:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0029-0001', 122.45, 'JOD', 122, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-04-1', '99999999-0000-0000-0000-000000000010', '2026-05-04 18:05:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0029-0002', 112.84, 'JOD', 112, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-04-2', '99999999-0000-0000-0000-000000000009', '2026-05-04 18:00:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.earn_transaction (earn_id, "PurchaseAmount", "PurchaseCurrency", points_earned, shop_id, transaction_ref, user_id, created_at)
VALUES ('eeeeeeee-0000-0000-0029-0003', 131.57, 'JOD', 131, '66666666-0000-0000-0000-000000000001', 'TX-ZARA-2026-05-04-3', '99999999-0000-0000-0000-000000000003', '2026-05-04 11:21:00+00')
ON CONFLICT (earn_id) DO NOTHING;
INSERT INTO public.redeem_transaction (redeem_id, "DiscountAmount", "DiscountCurrency", applied_points_to_currency_ratio, points_used, shop_id, status, user_id, verification_code, created_at, completed_at)
VALUES ('dddddddd-0000-0000-0029-0000', 20.0, 'JOD', 10.0, 200, '66666666-0000-0000-0000-000000000001', 'completed', '99999999-0000-0000-0000-000000000002', '863684', '2026-05-04 20:09:00+00', '2026-05-04 20:09:00+00')
ON CONFLICT (redeem_id) DO NOTHING;

-- 6. Seed Receipts
INSERT INTO public.receipt (receipt_id, "Amount", "Currency", status, user_id, shop_id, receipt_path, image_hash, receipt_details, created_at)
VALUES ('bbbbbbbb-0000-0000-0000-000000000001', 45.5, 'JOD', 'pending', '99999999-0000-0000-0000-000000000001', '66666666-0000-0000-0000-000000000001', 'receipts/bbbbbbbb-0000-0000-0000-000000000001.jpg', 'h1', '{"tax": 0.16, "items_count": 2}', '2026-06-02 14:00:00+00')
ON CONFLICT (receipt_id) DO NOTHING;
INSERT INTO public.receipt (receipt_id, "Amount", "Currency", status, user_id, shop_id, receipt_path, image_hash, receipt_details, created_at)
VALUES ('bbbbbbbb-0000-0000-0000-000000000002', 120.0, 'JOD', 'pending', '99999999-0000-0000-0000-000000000002', '66666666-0000-0000-0000-000000000001', 'receipts/bbbbbbbb-0000-0000-0000-000000000002.jpg', 'h2', '{"tax": 0.16, "items_count": 2}', '2026-06-02 16:30:00+00')
ON CONFLICT (receipt_id) DO NOTHING;
INSERT INTO public.receipt (receipt_id, "Amount", "Currency", status, user_id, shop_id, receipt_path, image_hash, receipt_details, created_at)
VALUES ('bbbbbbbb-0000-0000-0000-000000000003', 75.0, 'JOD', 'approved', '99999999-0000-0000-0000-000000000003', '66666666-0000-0000-0000-000000000001', 'receipts/bbbbbbbb-0000-0000-0000-000000000003.jpg', 'h3', '{"tax": 0.16, "items_count": 2}', '2026-06-01 11:00:00+00')
ON CONFLICT (receipt_id) DO NOTHING;
INSERT INTO public.receipt (receipt_id, "Amount", "Currency", status, user_id, shop_id, receipt_path, image_hash, receipt_details, created_at)
VALUES ('bbbbbbbb-0000-0000-0000-000000000004', 35.0, 'JOD', 'rejected', '99999999-0000-0000-0000-000000000004', '66666666-0000-0000-0000-000000000001', 'receipts/bbbbbbbb-0000-0000-0000-000000000004.jpg', 'h4', '{"tax": 0.16, "items_count": 2}', '2026-05-30 09:15:00+00')
ON CONFLICT (receipt_id) DO NOTHING;

COMMIT;
