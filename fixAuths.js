var count = 0; db.dashboards.aggregate([{$match:{"owners.authType": {$exists : false}}}]).forEach( function(myDoc) { var ownerName = myDoc.owner; print("Updating owner information for dashboard title --"+ myDoc.title+ " owner name --"+myDoc.owner); db.dashboards.update( { _id: myDoc._id}, { $push: { owners: { $each: [{username: ownerName, authType: "STANDARD"}] } } } ) db.dashboards.update({_id: myDoc._id},{$unset: {owner:1}},{multi: true}); count++; } ); print(count+" dashboards updated successfully");