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
        test.deepEqual(this.v.getStock(3), {
                "name": "water"
                ,"stock": 5
                ,"price": 100
            }
        );
        test.done();
    }
});
