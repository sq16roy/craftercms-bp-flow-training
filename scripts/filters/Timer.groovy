def start = System.currentTimeMillis()


filterChain.doFilter(request, response)
 
 
def stop = System.currentTimeMillis()

def totalTime = stop - start

logger.info("XXXXXXXXX : " + totalTime + "ms   " + request.getRequestURI() )
