package dao;

public class FeedObj {
	private String no, uid, content, ts, images;
	
	public FeedObj(String no, String uid, String content, String ts, String images) {
		this.no = no;
		this.uid = uid;
		this.content = content;
		this.ts = ts;
		this.images = images;
	}
	
	public String getNo() {return this.no;}
	public String getId() {return this.uid;}
	public String getContent() {return this.content;}
	public String getTs() {return this.ts;}
	public String getImages() {return this.images;}
}