with source as (

    select * from {{ source('thelook_ecommerce', 'order_items') }}

),

renamed as (

    select
        id AS order_item_id,
        order_id,
        user_id,
        product_id,
        sale_price AS item_sale_price
        {# inventory_item_id,
        status,
        created_at,
        shipped_at,
        delivered_at,
        returned_at, #}

    from source

)

select * from renamed