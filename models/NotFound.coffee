###
 library.js
 Copyright © 2013 Markus Mayer <widemeadows@gmail.com>.

 This source code is licensed under the EUPL, Version 1.1 or - as soon they will be approved
 by the European Commission - subsequent versions of the EUPL (the "Licence"); you may not
 use this work except in compliance with the Licence. You may obtain a copy of the Licence at:
 <http://joinup.ec.europa.eu/software/page/eupl/licence-eupl>

 A copy is also distributed with this source code.
 Unless required by applicable law or agreed to in writing, software distributed under the
 Licence is distributed on an “AS IS” basis, without warranties or conditions of any kind.
###

exports.NotFound = (msg) ->
	this.name = 'NotNound'
	Error.call(this, msg)
	Error.captureStackTrace(this, arguments.callee)
	return