exports.init = function () {
    var current = 0;
    return {
        insert : function(money){
            current = current + money;
        }
    };
};
