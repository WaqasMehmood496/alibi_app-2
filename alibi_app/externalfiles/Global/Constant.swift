//
//  Constant.swift
//  Futbolist
//
//  Created by Adeel on 19/12/2019.
//  Copyright © 2019 Buzzware. All rights reserved.
//

import UIKit

struct Constant {
    
       
    static let v2 = "v2/"
    static let version = "api/"
    static let mainUrl = "http://3.138.48.235:80/" + version + v2
    
    //Login Api Endpoints
    static let auth_login = "auth/login"
    static let login_cache_Key = "login_cache_Key"
    static let login_key = "login_key"
        //// model key's
    static let token_key = "token"
    
    // Product Api Endpoints
    static let products = "products/"
        //// model key's
    static let id = "id"
    static let name = "name"
    static let description = "description"
    static let price = "price"
    static let price_per_case = "price_per_case"
    static let qty_per_case = "qty_per_case"
    static let image_url = "image_url"
    static let metadata = "metadata"
    static let created_at = "created_at"
    static let favorite = "favorite"
    
    // Categories Api Endpoints
    static let categories = "categories"
    static let subcategories = "subcategories"
    static let categories_cache_key = "categories_cache_key"
    static let product_cache_key = "product_cache_key"
    
    // Orders Api Endpoints
    static let orders = "orders/"
            //// Orders Model key's
    static let contact_person = "contact_person"
    static let phone_number = "phone_number"
    static let ordered_by = "ordered_by"
    static let delivery_address = "delivery_address"
    static let ordered_products = "ordered_products"
    static let order_status = "order_status"
    static let total_price = "total_price"
    
            ////// Order By Model Key's
    static let first_name = "first_name"
    static let last_name = "last_name"
    static let email = "email"
            ////// Delivery Address Model Key's
    static let street_address_1 = "street_address_1"
    static let street_address_2 = "street_address_2"
    static let city = "city"
    static let zipcode = "zipcode"
    static let state_id = "state_id"
    static let country_id = "country_id"
    static let latitude = "latitude"
    static let longitude = "longitude"
            ////// Quantity model Key's
    static let quantity = "quantity"
    static let product = "product"
        ////// Store model Key's
    static let store = "store"
        ////// Order Status model Key's
    static let updated_at = "updated_at"
    
    
    
    
    
    static let gstPrice = 13.0
    static let servicePrice = 2.92
    static let defLatt = 43.54762429
    static let defLong = -79.62600543
    static let Card = "Card"
    static let card_id = "card_id"
    static let card_num = "card_num"
    static let card_month = "card_month"
    static let card_year = "card_year"
    static let card_cvv = "card_cvv"
    static let card_sid = "card_sid"
    static let card_postcode = "card_postcode"
    
    static let token = "token"
    static let success = "success"
    static let sucess = "sucess"
    static let return_data = "return_data"
    static let error = "error"
    static let message = "message"
    static let username = "username"
    static let password = "password"
    static let status = "status"
    static let unlike = "unlike"
    static let like = "like"
    static let data = "data"
    
    static let stripeId = "stripeId"
    static let ca_firstname = "ca_firstname"
    static let ca_lastname = "ca_lastname"
    static let ca_email = "ca_email"
    //static let email = "email"
    static let ca_username = "ca_username"
    static let ca_password = "ca_password"
    static let ca_oath_id = "ca_oath_id"
    static let ca_type = "ca_type"
    static let ca_image_url = "ca_image_url"
    static let image = "image"
    
    static let ca_id = "ca_id"
    static let ca_status = "ca_status"
    static let is_verify = "is_verify"
    static let ca_created_at = "ca_created_at"
    static let ca_create_day = "ca_create_day"
    static let ca_create_month = "ca_create_month"
    static let ca_create_year = "ca_create_year"
    static let ca_address = "ca_address"
    static let ca_lat = "ca_lat"
    static let ca_lng = "ca_lng"
    static let ca_age = "ca_age"
    
    
    static let result = "result"
    static let orderTypeDate = "orderTypeDate"
    
    static let order_lat = "order_lat"
    static let order_lng = "order_lng"
    static let order_address = "order_address"
    static let lat = "lat"
    static let lng = "lng"
    static let distance = "distance"
    static let main_cat_name = "main_cat_name"
    static let lowerlimittime = "lowerlimittime"
    static let upperlimittime = "upperlimittime"
    static let customer_id = "customer_id"
    static let user_id = "user_id"
    static let user_lat = "user_lat"
    static let user_long = "user_long"
    static let token_id = "token_id"
    
    
    static let cat_id = "cat_id"
    static let cat_index = "cat_index"
    static let cat_name = "cat_name"
    //static let id = "id"
    static let preview = "preview"
    static let msg = "msg"
    
    
    static let feature_video = "feature_video"
    static let video_id = "video_id"
    static let video_url = "video_url"
    
    static let res_id = "res_id"
    static let res_index = "res_index"
    static let res_name = "res_name"
    
    
    
    static let restaurant_id = "restaurant_id"
    static let restaurant_name = "restaurant_name"
    static let restaurant_description = "restaurant_description"
    static let res_image_url = "res_image_url"
    static let meal_type = "meal_type"
    static let meal_prepration_start_time = "meal_prepration_start_time"
    static let meal_prepration_end_time = "meal_prepration_end_time"
    static let meal_real_price = "meal_real_price"
    static let meals_id = "meals_id"
    static let meals_image_url = "meals_image_url"
    static let meals_days_id = "meals_days_id"
    static let restaurant_lat = "restaurant_lat"
    static let restaurant_lng = "restaurant_lng"
    static let restaurant_address = "restaurant_address"
    static let res_complete_Address = "res_complete_Address"
    static let day = "day"
    static let discount_price = "discount_price"
    static let totalquantity = "totalquantity"
    static let available_quantity = "available_quantity"
    static let inserted_date = "inserted_date"
    static let like_status = "like_status"
    static let remaining_quantity = "remaining_quantity"
    
    static let meail = "meail"
    static let meal_status = "meal_status"
    static let meal_inserted_date = "meal_inserted_date"
    static let meals_days = "meals_days"
    //static let quantity = "quantity"
    static let meals_upload = "meals_upload"
    
    static let restaurant_branch_name = "restaurant_branch_name"
    static let restaurant_phone_no = "restaurant_phone_no"
    
    static let notification_id = "notification_id"
    static let notification_text = "notification_text"
    static let notification_inserted_date = "notification_inserted_date"
    static let isNotify = "isNotify"
    
    
    static let order_id = "order_id"
    //static let order_status = "order_status"
    static let order_deliver_time = "order_deliver_time"
    static let order_deliver_date = "order_deliver_date"
    static let bill = "bill"
    static let order_quantity = "order_quantity"
    static let order_type = "order_type"
    
    static let card_number = "card_number"
    
    
    // TableView Cell Identifiers
    static let Profile_Cell_Identifier = "ProfileCellIdentifier"
    static let Search_Location_Identifier = "SearchLocationIdentifier"
    static let Amazon_Cell_Identifier = "AmazonCellIdentifier"
    
    
}
