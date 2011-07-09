var vender = require('../lib/vender').vender;
console.log(vender);
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
        this.v.insert(1000);
        test.deepEqual(this.v.getAvailable(), [1]);
        test.done();
    }

    ,'ID2レッドブル5本200円の在庫を追加できる': function(test){
        var stock = {
            "name": "redbull"
            ,"stock": 5
            ,"price": 200
        };
        this.v.addStock(2, stock);
        this.v.insert(1000);
        test.deepEqual(this.v.getAvailable(), [1,2]);
        test.deepEqual(this.v.getStock(2), {
                "name": "redbull"
                ,"stock": 5
                ,"price": 200
            }
        );
        test.done();
    }
    ,'ID3水5本100円の在庫を追加できる': function(test){
        var stock = {
            "name": "water"
            ,"stock": 5
            ,"price": 100
        };
        this.v.addStock(3, stock);
        this.v.insert(1000);
        test.deepEqual(this.v.getAvailable(), [1,3]);
        test.deepEqual(this.v.getStock(3), {
                "name": "water"
                ,"stock": 5
                ,"price": 100
            }
        );
        test.done();
    }
    ,'ID1を購入するとID1の在庫数が4になる': function(test){
        this.v.insert(1000);
        this.v.sell(1);
        test.equal(this.v.getStock(1).stock, 4);
        test.done();
    }
    ,'ID1を3回購入すると売上が360円になる': function(test){
        this.v.insert(1000);
        this.v.sell(1);
        this.v.sell(1);
        this.v.sell(1);
        test.equal(this.v.getTotalAmount(), 360);
        test.done();
    }
    ,'現在の在庫数が算出される': function(test){
        test.done();
    }
    ,'ID1を6回購入すると在庫切れで例外が発生する': function(test){
        var v = this.v;
        v.insert(1000);
        v.sell(1);
        v.sell(1);
        v.sell(1);
        v.sell(1);
        v.sell(1);
        test.throws( function(){v.sell(1)} );
        test.done();
    }
});
