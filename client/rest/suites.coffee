class SuitesApi
  append: (suite, { onSuccess, onError }) =>
    request = $.post
      url: '/suites/append'
      data: JSON.stringify { name: suite.name, command: suite.command }
      dataType: 'json'
    request.done (suitId) =>
      if suitId._id?
        _.extend suite, { _id: suitId._id }
        onSuccess { suite }
      else
        onError 'Server does not return valid id.'
    request.fail (err) => onError { message: err.responseText }

  list: ({ onSuccess, onError }) =>
    request = $.get { url: '/suites/list' }
    request.done (suitesList) => onSuccess suitesList
    request.fail (err) => onError { message: err.responseText }

  update: (suite, { command }, { onSuccess, onError }) =>
    request = $.post
      url: "/suites/update"
      data:  JSON.stringify { _id: suite._id, command }
      dataType: 'json'
    request.done (status) => onSuccess { }
    request.fail (err) => onError { message: err.responseText }

export default new SuitesApi
