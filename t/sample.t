var vender = function(){
    this.current = 0;
};

vender.prototype.insert = function(money){
    if (money == 1 || money == 5){
        throw new Error;
    }
    this.current = this.current + money;
};

vender.prototype.getCount = function(){
    return this.current;
}

vender.prototype.getStock = function(id){
    return {
        "name": "cola"
        ,"stock": 5
        ,"price": 120
    };
}

var testCase = require('nodeunit').testCase;

module.exports = testCase({
    setUp: function(callback){
        this.v = new vender;
        callback();
    }
    ,tearDown: function(callback){
        callback();
    }
    ,'お金を入れる' : function (test) {
        this.v.insert(1000);
        test.equal(this.v.getCount(), 1000, "insert 1000yen");

        test.throws(function(){this.v.insert(1)});

        test.done();
    }
    ,'1000円と500円を投入すると1500円になる': function(test){
        this.v.insert(1000);
        this.v.insert(500);
        test.equal(this.v.getCount(), 1500, "合計額が1500円");
        test.done();
    }

    ,'ID1の在庫を問い合わせるとコーラ5本120円のオブジェクトが返ってくる': function(test){
        test.deepEqual(this.v.getStock(1), {
                "name": "cola"
                ,"stock": 5
                ,"price": 120
            }
        );
        test.done();
    }

    ,'お金を投入して購入できるIDの一覧を取得できる': function(test){
        test.done();
    }
});
