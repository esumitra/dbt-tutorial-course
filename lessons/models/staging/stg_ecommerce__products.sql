with source as (

    select * from {{ source('thelook_ecommerce', 'products') }}

),

renamed as (

    select
        id as product_id,
        cost,
        retail_price,
        department,
        brand,

        {# category,
        name,
        sku,
        distribution_center_id #}

    from source

)

select * from renamed