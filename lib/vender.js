exports.vender = function(){
    this.current = 0;
    this.stock = {
        1: {
            "name": "cola"
            ,"stock": 5
            ,"price": 120
        }
    };
    this.totalAmount = 0;
};

exports.vender.prototype = {
    insert : function(money){
        if (money == 1 || money == 5){
            throw new Error;
        }
        this.current = this.current + money;
    }
    ,getCount : function(){
        return this.current;
    }
    ,getStock : function(id){
        return this.stock[id];
    }
    ,getAvailable : function(){
        var ret = [];
        for (var id in this.stock){
            if (this.stock[id].price <= this.current){
                ret.push(id);
            }
        }
        return ret;
    }
    ,addStock : function(id, stock){
        this.stock[id] = stock;
    }
    ,sell : function(id){
        if (this.stock[id].stock > 0){
            this.stock[id].stock--;
        } else {
            throw new Error;
        }
        this.totalAmount += this.stock[id].price;
    }
    ,getTotalAmount : function(){
        return this.totalAmount;
    }
};


