package org.z.common.exception;

/**
 * @author z
 */
public class ZBootException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public ZBootException(String message){
		super(message);
	}

	public ZBootException(Throwable cause)
	{
		super(cause);
	}

	public ZBootException(String message, Throwable cause)
	{
		super(message,cause);
	}
}
