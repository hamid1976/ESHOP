function add_to_cart(pid,pname,price){
    
  let cart =localStorage.getItem("cart");
  
  if(cart ==null){
      
      //no cart
           let products=[];
           let product={productId:pid,productName:pname,productQuantity:1,productPrice:price}
           products.push(product);
           localStorage.setItem("cart", JSON.stringify(products));
           
          // console.log("product is added first time")
           showToast("item is added to cart")
  }else{
      
      // cart already present
       let pcart  =JSON.parse(cart);
       
      let oldProduct = pcart.find((item)=>item.productId==pid)
      
        
        if(oldProduct){
            // we have to increase the quantity
        oldProduct.productQuantity =oldProduct.productQuantity+1;
        
        pcart.map( (item)=>{
            
            if(item.productId==oldProduct.productId){
                item.productQuantity=oldProduct.productQuantity;
                    
            }
            
           localStorage.setItem("cart", JSON.stringify(pcart)); 
           
          // console.log("product quantity is increased")
                showToast(oldProduct.productName+"product quantity is increased,Quantity = "+oldProduct.productQuantity)
        })
            
        }
        else {
            
           // we have to add quantity 
            let product={productId:pid,productName:pname,productQuantity:1,productPrice:price}
           pcart.push(product)
           localStorage.setItem("cart", JSON.stringify(pcart));
            
          //  console.log("product is added")
            showToast("item is added to cart")
        }
  }
  
 updateCart();
}

// update cart

function updateCart(){
    
    let cartString=localStorage.getItem("cart");
   let cart  =JSON.parse(cartString);
   
   if(cart==null || cart.length==0)
   {
       console.log("cart is empty !!")
       $(".cart-items").html("(0)");
       $(".cart-body").html("<h3> cart does not have any item</h3");
       $(".checkout-btn").attr('disabled',true);
   }else{
       // there is something
       console.log(cart)
        $(".cart-items").html(`(${cart.length})`);
        
         let table =`
                
                 <table class="table">
                       <thead class="thead-light ">
        
        
                  <tr>
                    <th>Item name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>total price</th>
                    <th>Action</th>
                  
                  </tr>
        
        </thead>
        
        



`;
        let totalPrice=0;
        
        cart.map((item)=>{
            
            table+=`
                    <tr>
                       <td>${item.productName } </td>
                       <td>${item.productPrice } </td>
                       <td>${item.productQuantity } </td>
                       <td>${item.productQuantity*item.productPrice } </td>
                        <td><button onclick="deleteItemFromCart(${item.productId})" class="btn btn-danger btn-sm">Remove</button> </td>   
                    


                    </tr>
                    `
            totalPrice+=item.productPrice*item.productQuantity;
            
        })
      table=table+`
         <tr> <td colspan="5" class="text-right font-weight-bold m-5"> Total price:${totalPrice}  </td>   </tr>

</table>` 
        $(".cart-body").html(table);
        $(".checkout-btn").attr('disabled',false);
   }
      
}
// remove item
function deleteItemFromCart(pid){
    
  let cart=  JSON.parse(localStorage.getItem('cart'));
       let newcart =cart.filter((item)=> item.productId != pid)
       localStorage.setItem('cart',JSON.stringify(newcart))
    
    
    updateCart();
    showToast("item is removed from cart")
    
}

$(document).ready(function(){
    updateCart();
})


function showToast(content){
    $("#toast").addClass("display");
    $("#toast").html(content);
    
    setTimeout(()=>{
        
        $("#toast").removeClass("display");
        
        
    },2000);
}

function goToCheckout(){
    
    window.window.location="checkout.jsp"
    
     
  
}
 
function orderConfirmed(){
   
          
        showToast("ordered")
        
     
                
               //localStorage();
      
}





 
 
 
